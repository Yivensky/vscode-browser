output "cloudfront_endpoint" {
  value = "https://${aws_cloudfront_distribution.code.domain_name}"
  description = "Cloudfront endpoint URL"
}