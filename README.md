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
| terraform | >= 0.13 |
| aws | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| domain\_name | A domain name for which the certificate should be issued. | `string` | n/a | yes |
| route53\_zone\_id | The ID of the hosted zone to contain the domain validation records.  Only used if the validation method is set to "DNS". | `string` | `null` | no |
| subject\_alternative\_names | Set of domains that should be SANs in the issued certificate. | `list(string)` | `null` | no |
| tags | Tags to apply to the ACM certificate. | `map(string)` | `{}` | no |
| validation\_method | Which method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform. | `string` | `"NONE"` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the certificate. |
| domain\_validation\_options | Set of domain validation objects which can be used to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used. |
| validation\_emails | A list of addresses that received a validation E-Mail. Only set if EMAIL-validation was used. |

