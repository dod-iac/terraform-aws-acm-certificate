variable "domain_name" {
  type        = string
  description = "A domain name for which the certificate should be issued."
}

variable "route53_zone_id" {
  description = "The ID of the hosted zone to contain the domain validation records.  Only used if the validation method is set to \"DNS\"."
  type        = string
  default     = null
}

variable "subject_alternative_names" {
  type        = list(string)
  description = "Set of domains that should be SANs in the issued certificate."
  default     = null
}

variable "tags" {
  description = "Tags to apply to the ACM certificate."
  type        = map(string)
  default     = {}
}

variable "validation_method" {
  type        = string
  description = "Which method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform."
  default     = "NONE"
}
