variable "project_name" {
  description = "The name of the project. Used as a prefix for all resource names."
  type        = string
  default     = "prod-2048-aks-app"
}

variable "environment" {
  description = "Deployment environment (dev, staging, or prod)."
  type        = string
}

variable "location" {
  description = "Azure region"
  default     = "uksouth"
}

variable "rg_name" {
  description = "Resource group name for all resources managed by terraform"
  type        = string
  default     = "rg-2048-aks-tf"
}

variable "pod_cidr" {
  description = "CIDR for pod IPs (CNI Overlay). Must not overlap the VNet or service CIDR."
  type        = string
  default     = "10.244.0.0/16"
}
