variable "oidc_issuer_url" {
  description = "OIDC issuer URL from the k8s cluster for ExternalDNS."
  type        = string
}

variable "external_dns_identity_id" {
  description = "Resource ID of the ExternalDNS identity, created in the bootstrap stack."
  type        = string
}
