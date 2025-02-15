# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2025-02-15  
### 🚀 Added  
- Lifecycle precondition to the Cloudfront Distribution to ensure that ec2 instance has public dns name.

### 🐛 Fixed  
- EC2 postcondition value from `null` to `""`.

### 🔧 Changes    
- CloudFront distributions now use HTTP/2 by default.  
- `vpc_id` and `region` are now optional variables.  
- `code_version` is now a required variable.  
- Default value for `subnet_id` changed from `""` to `null`.
- `README.md` updated.

## [1.0.1] - 2025-02-12  
### 🔧 Changes  
- Updated `README.md` with latest modifications.

## [1.0.0] - 2025-02-12  
### 🚀 Added  
- First release of the project.