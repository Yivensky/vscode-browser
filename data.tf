# Retrieve the cloudfront origins prefix list
data "aws_ec2_managed_prefix_list" "cloudfront" {
  name = "com.amazonaws.global.cloudfront.origin-facing"
}
# Retrieve the ami id depending of your needs
data "aws_ssm_parameter" "al2023_ami_id" {
  name = local.architecture_type
}

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}