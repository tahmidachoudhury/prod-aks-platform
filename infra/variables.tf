variable "project_name" {
  description = "The name of the project. Used as a prefix for all resource names."
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, staging, or prod)."
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "rg_name" {
  description = "Resource group name for all resources managed by terraform"
  type        = string
}

variable "pod_cidr" {
  description = "CIDR for pod IPs (CNI Overlay). Must not overlap the VNet or service CIDR."
  type        = string
  default     = "10.244.0.0/16"
}

variable "dns_zone_name" {
  description = "The DNS record assigned to the project"
  type        = string
}
