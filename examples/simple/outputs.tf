// =================================================================
//
// Work of the U.S. Department of Defense, Defense Digital Service.
// Released as open source under the MIT License.  See LICENSE file.
//
// =================================================================

output "tags" {
  value = var.tags
}

output "test_name" {
  value = var.test_name
}

output "arn" {
  value = module.acm_certificate.arn
}

output "domain_validation_options" {
  value = module.acm_certificate.domain_validation_options
}

output "validation_emails" {
  value = module.acm_certificate.validation_emails
}
