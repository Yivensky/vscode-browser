locals {
  prefix_name = "code-browser"
  prefixname  = "CodeBrowser"
  # Determine the architecture type based on the instance_arm64_architecture variable
  instance_arm64_architecture_map = {
    true  = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-arm64"      # Latest AL2023 ARM64
    false = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64" # Latest AL2023 x86_64
  }
  architecture_type = local.instance_arm64_architecture_map[var.instance_arm64_architecture]
}