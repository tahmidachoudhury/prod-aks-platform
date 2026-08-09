variable "project_name" {
  description = "The name of the project. Used as a prefix for all resource names."
  type        = string
  default     = "prod-2048-aks-app"
}

variable "environment" {
  description = "Deployment environment (dev, staging, or prod)."
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group for the DNS and all resources managed by Terraform."
  type        = string
}

variable "rg_location" {
  description = "The Azure region for the External DNS service."
  type        = string
}

variable "dns_zone_name" {
  description = "The DNS record assigned to the project"
  type        = string
}

variable "oidc_issuer_url" {
  description = "OIDC issuer URL from the k8s cluster for ExternalDNS."
  type        = string
}
