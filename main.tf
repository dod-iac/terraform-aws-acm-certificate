/**
 * ## Usage
 *
 * Creates an AWS ACM certificate and validates using Route53.
 *
 * ```hcl
 * module "acm_certificate" {
 *   source = "dod-iac/acm-certificate/aws"
 *
 *   domain_name = "example.com"
 *   subject_alternative_names = ["www.example.com"]
 *   route53_zone_id = var.route53_zone_id
 *   validation_method = "DNS"
 *   tags = {
 *     Automation  = "Terraform"
 *   }
 * }
 * ```
 *
 * Creates an AWS ACM certificate and validates using email.
 *
 * ```hcl
 * module "acm_certificate" {
 *   source = "dod-iac/acm-certificate/aws"
 *
 *   domain_name = "example.com"
 *   subject_alternative_names = ["www.example.com"]
 *   validation_method = "EMAIL"
 *   tags = {
 *     Automation  = "Terraform"
 *   }
 * }
 * ```
 *
 * ## Terraform Version
 *
 * Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.
 *
 * Terraform 0.11 and 0.12 are not supported.
 *
 *
 * ## License
 *
 * This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.
 */

resource "aws_acm_certificate" "main" {
  domain_name = var.domain_name

  subject_alternative_names = var.subject_alternative_names

  validation_method = var.validation_method

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

resource "aws_route53_record" "cert_validation" {
  for_each = var.validation_method == "DNS" ? {
    for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  } : {}

  name    = each.value.name
  records = [each.value.record]
  type    = each.value.type
  zone_id = var.route53_zone_id
  ttl     = 60
}

resource "aws_acm_certificate_validation" "main" {
  count                   = (var.validation_method == "DNS" || var.validation_method == "EMAIL") ? 1 : 0
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = var.validation_method == "DNS" ? [for record in aws_route53_record.cert_validation : record.fqdn] : null
}
