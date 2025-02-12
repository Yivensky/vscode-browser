# cloudfront distribution with my ec2 instance as origin
resource "aws_cloudfront_distribution" "code" {
  enabled         = true
  is_ipv6_enabled = true
  comment         = "${local.prefix_name} Cloudfront Distribution"
  http_version    = "http1.1"
  origin {
    domain_name = aws_instance.code.public_dns
    origin_id   = local.prefix_name
    custom_origin_config {
      http_port              = 8080
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1"]
    }
  }


  #default_root_object = "index.html"

  default_cache_behavior {
    cached_methods           = ["GET", "HEAD"]
    cache_policy_id          = aws_cloudfront_cache_policy.caching.id
    origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3" #All Viewer
    allowed_methods          = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    target_origin_id         = local.prefix_name

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }
  price_class = "PriceClass_100"
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
# Create cloudfront cache policy
resource "aws_cloudfront_cache_policy" "caching" {
  name        = local.prefix_name
  comment     = "${local.prefix_name} Cache Policy"
  default_ttl = 86400
  min_ttl     = 1
  max_ttl     = 31536000
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "all"
    }
    headers_config {
      header_behavior = "whitelist"
      headers {
        items = [
          "Accept-Charset",
          "Authorization",
          "Origin",
          "Accept",
          "Referer",
          "Host",
          "Accept-Language",
          "Accept-Encoding",
          "Accept-Datetime"
        ]
      }
    }
    query_strings_config {
      query_string_behavior = "all"
    }
  }
}