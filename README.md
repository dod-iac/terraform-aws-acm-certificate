<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Usage

Creates an AWS ACM certificate and validates using Route53.

```hcl
module "acm_certificate" {
  source = "dod-iac/acm-certificate/aws"

  domain_name = "example.com"
  subject_alternative_names = ["www.example.com"]
  route53_zone_id = var.route53_zone_id
  validation_method = "DNS"
  tags = {
    Automation  = "Terraform"
  }
}
```

Creates an AWS ACM certificate and validates using email.

```hcl
module "acm_certificate" {
  source = "dod-iac/acm-certificate/aws"

  domain_name = "example.com"
  subject_alternative_names = ["www.example.com"]
  validation_method = "EMAIL"
  tags = {
    Automation  = "Terraform"
  }
}
```

## Terraform Version

Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.

Terraform 0.11 and 0.12 are not supported.

## License

This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.cert_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | A domain name for which the certificate should be issued. | `string` | n/a | yes |
| <a name="input_route53_zone_id"></a> [route53\_zone\_id](#input\_route53\_zone\_id) | The ID of the hosted zone to contain the domain validation records.  Only used if the validation method is set to "DNS". | `string` | `null` | no |
| <a name="input_subject_alternative_names"></a> [subject\_alternative\_names](#input\_subject\_alternative\_names) | Set of domains that should be SANs in the issued certificate. | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the ACM certificate. | `map(string)` | `{}` | no |
| <a name="input_validation_method"></a> [validation\_method](#input\_validation\_method) | Which method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform. | `string` | `"NONE"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the certificate. |
| <a name="output_domain_validation_options"></a> [domain\_validation\_options](#output\_domain\_validation\_options) | Set of domain validation objects which can be used to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used. |
| <a name="output_validation_emails"></a> [validation\_emails](#output\_validation\_emails) | A list of addresses that received a validation E-Mail. Only set if EMAIL-validation was used. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
