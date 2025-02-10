# Network related variables
variable "region" {
  type        = string
  description = "Specify the AWS region to use."
}
variable "vpc_id" {
  type        = string
  description = "Specify the VPC ID to use."
}
variable "subnet_id" {
  type        = string
  description = "Specify the subnet ID to use instead of the default one."
  default     = ""
}

# Instance related variables
variable "instance_type" {
  type        = string
  description = "Instance type to use."
  default     = "t4g.micro"
}
variable "instance_ebs_size" {
  type        = number
  description = "EBS disk size used by the instance."
  default     = 50
}
variable "instance_arm64_architecture" {
  type = bool
  description = "Do you want to use ARM64 as architecture?"
  default = true
}

# coder-code related variables
variable "code_version" {
  type        = string
  description = "Which version to use of coder-code"
  default     = "4.95.3"
}
variable "code_custom_password" {
  type = string
  description = "Define a custom password instead of the instance ID as a password."
  default = ""
}
variable "code_port" {
  type = string
  description = "Which port to expose?"
  default = "8080"
}