# Network related variables
variable "region" {
  type        = string
  description = "Specify the AWS region to use."
  default     = null
}
variable "vpc_id" {
  type        = string
  description = "Specify the VPC ID to use."
  default     = null
}
variable "subnet_id" {
  type        = string
  description = "Specify the subnet ID to use instead of the default one."
  default     = null
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
  type        = bool
  description = "Do you want to use ARM64 as architecture?"
  default     = true
}

# coder-code related variables
variable "code_version" {
  type        = string
  description = "Which version to use of coder-code"
}
variable "code_port" {
  type        = string
  description = "Which port to expose?"
  default     = "8080"
}