resource "aws_instance" "code" {
  ami                    = data.aws_ssm_parameter.al2023_ami_id.value
  instance_type          = var.instance_type
  vpc_security_group_ids = [module.code_browser_sg.security_group_id]
  subnet_id              = var.subnet_id
  iam_instance_profile   = aws_iam_instance_profile.app.name
  user_data = templatefile("${path.root}/config/user-data.sh",
    {
      VERSION = var.code_version,
      USER    = "ec2-user",
  })
  # Force encryption on root and ebs volume
  root_block_device {
    encrypted = true
  }
  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = var.instance_ebs_size
    encrypted   = true
  }

  # Force Metadata Token to be required
  metadata_options {
    http_tokens = "required"
  }

  # Flag error if no public DNS, which is required for CloudFront
  lifecycle {
    postcondition {
      condition     = self.public_dns != ""
      error_message = "The instance must be in a public subnet with a IPv4 address attached to be used with CloudFront."
    }
  }
  tags = {
    Name = local.prefix_name
  }
}

# Security group for the instance
module "code_browser_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name        = "${local.prefix_name}-sg"
  description = "${local.prefix_name} web app exposed port"
  vpc_id      = var.vpc_id
  ingress_with_prefix_list_ids = [
    {
      from_port       = var.code_port
      to_port         = var.code_port
      protocol        = "tcp"
      description     = "${local.prefix_name} exposed port"
      prefix_list_ids = data.aws_ec2_managed_prefix_list.cloudfront.id
    }
  ]
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]
}