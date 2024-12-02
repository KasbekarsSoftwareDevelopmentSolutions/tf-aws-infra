# File orgInfra/modules/acm/variables.tf

variable "certificate_name" {
  description = "Name of the certificate"
  type        = string
}

variable "private_key" {
  description = "Private key of the certificate"
  type        = string
}

variable "certificate_body" {
  description = "Certificate body"
  type        = string
}

variable "certificate_chain" {
  description = "Certificate chain"
  type        = string
}
