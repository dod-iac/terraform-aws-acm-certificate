output "arn" {
  description = "The ARN of the certificate."
  value       = aws_acm_certificate.main.arn
}

output "domain_validation_options" {
  description = "Set of domain validation objects which can be used to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used."
  value       = aws_acm_certificate.main.domain_validation_options
}

output "validation_emails" {
  description = "A list of addresses that received a validation E-Mail. Only set if EMAIL-validation was used."
  value       = aws_acm_certificate.main.validation_emails
}
