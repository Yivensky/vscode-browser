# code-browser
Launch easily a Visual Studio Code instance within a browser.
Connect securely through your code browser from a CloudFront endpoint, using your instance ID as a password.

## Architecture
The architecture of this solution uses [code-server](https://github.com/coder/code-server) to run Visual Studio Code within the browser, with secure access managed through an AWS CloudFront distribution.  
The deployment leverages EC2 instances, VPCs, and appropriate security configurations.

## How to Deploy

1. Clone the repository.
2. Configure a `terraform.tfvars` file. Ex:
    ```hcl
    region = "your-region"
    vpc_id = "your-vpc-id"
    subnet_id = "your-subnet-id"
    ```
    Refer to the full variables options below for more informations.
3. Connect your terminal to your AWS environement.
4. Initialize and apply the Terraform stack:
    ```bash
    terraform init
    terraform apply
    ```

5. Access your code-browser through the CloudFront endpoint. Use the EC2 instance ID as the password.

## Credits
Powered by [code-server](https://github.com/coder/code-server) and [Visual Studio Code](https://code.visualstudio.com/)
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.83.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.83.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_code_browser_sg"></a> [code\_browser\_sg](#module\_code\_browser\_sg) | terraform-aws-modules/security-group/aws | 5.3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_cache_policy.caching](https://registry.terraform.io/providers/hashicorp/aws/5.83.1/docs/resources/cloudfront_cache_policy) | resource |
| [aws_cloudfront_distribution.code](https://registry.terraform.io/providers/hashicorp/aws/5.83.1/docs/resources/cloudfront_distribution) | resource |
| [aws_iam_instance_profile.app](https://registry.terraform.io/providers/hashicorp/aws/5.83.1/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.app](https://registry.terraform.io/providers/hashicorp/aws/5.83.1/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.app_attach_ssm_policy](https://registry.terraform.io/providers/hashicorp/aws/5.83.1/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.code](https://registry.terraform.io/providers/hashicorp/aws/5.83.1/docs/resources/instance) | resource |
| [aws_ec2_managed_prefix_list.cloudfront](https://registry.terraform.io/providers/hashicorp/aws/5.83.1/docs/data-sources/ec2_managed_prefix_list) | data source |
| [aws_iam_policy_document.ec2_assume_role](https://registry.terraform.io/providers/hashicorp/aws/5.83.1/docs/data-sources/iam_policy_document) | data source |
| [aws_ssm_parameter.al2023_ami_id](https://registry.terraform.io/providers/hashicorp/aws/5.83.1/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_code_port"></a> [code\_port](#input\_code\_port) | Which port to expose? | `string` | `"8080"` | no |
| <a name="input_code_version"></a> [code\_version](#input\_code\_version) | Which version to use of coder-code | `string` | `"4.96.4"` | no |
| <a name="input_instance_arm64_architecture"></a> [instance\_arm64\_architecture](#input\_instance\_arm64\_architecture) | Do you want to use ARM64 as architecture? | `bool` | `true` | no |
| <a name="input_instance_ebs_size"></a> [instance\_ebs\_size](#input\_instance\_ebs\_size) | EBS disk size used by the instance. | `number` | `50` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type to use. | `string` | `"t4g.micro"` | no |
| <a name="input_region"></a> [region](#input\_region) | Specify the AWS region to use. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Specify the subnet ID to use instead of the default one. | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Specify the VPC ID to use. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudfront_endpoint"></a> [cloudfront\_endpoint](#output\_cloudfront\_endpoint) | n/a |
<!-- END_TF_DOCS -->