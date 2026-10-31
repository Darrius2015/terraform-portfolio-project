output "cloudfront_url" {
  description = "CloudFront domain name for the portfolio website"
  value       = aws_cloudfront_distribution.website.domain_name
}