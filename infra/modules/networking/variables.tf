variable "project_name" {
  description = "The name of the project. Used as a prefix for all resource names."
  type        = string
  default     = "prod-2048-aks-app"
}

variable "environment" {
  description = "Deployment environment (dev, staging, or prod)."
  type        = string
}

variable "vnet_name" {
  description = "The name of the VNet"
  type        = string
}

variable "snet_name" {
  description = "The name of the Subnet"
  type        = string
}

variable "rg_location" {
  description = "The Azure region for the VNet and subnet."
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group for the VNet and subnet and all resources managed by Terraform."
}

variable "address_space" {
  description = "CIDR range for VNet"
  type        = list(string)
}

variable "address_prefix_snet" {
  description = "CIDR range for Subnet"
  type        = list(string)
}

variable "pod_cidr" {
  description = "CIDR for pod IPs (CNI Overlay). CIDR in root variables.tf"
  type        = string
}
