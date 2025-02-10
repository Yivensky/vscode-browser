resource "aws_iam_role" "app" {
  name = "${local.prefixname}InstanceRole"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

# Create instance profile
resource "aws_iam_instance_profile" "app" {
  name = aws_iam_role.app.name
  role = aws_iam_role.app.name
}

resource "aws_iam_role_policy_attachment" "app_attach_ssm_policy" {
  role       = aws_iam_role.app.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}