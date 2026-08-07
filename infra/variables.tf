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
  default     = "rg-aks-platform-prod"
}
