/**
 * ## Usage
 *
 * This example is used by the `TestTerraformSimpleExample` test in `test/terrafrom_aws_simple_test.go`.
 *
 * ## Terraform Version
 *
 * This test was created for Terraform 0.13.
 *
 * ## License
 *
 * This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.
 */

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_route53_zone" "main" {
  name = var.domain_name
}

module "acm_certificate" {
  source = "../../"

  route53_zone_id           = aws_route53_zone.zone_id
  domain_name               = var.domain_name
  subject_alternative_names = [format("www.%s", var.domain_name)]
  validation_method         = "DNS"
  tags                      = var.tags
}
