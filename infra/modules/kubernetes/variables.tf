variable "project_name" {
  description = "The name of the project. Used as a prefix for all resource names."
  type        = string
  default     = "prod-2048-aks-app"
}

variable "environment" {
  description = "Deployment environment (dev, staging, or prod)."
  type        = string
}

variable "cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
  default     = "prod-aks-app"
}

variable "location" {
  description = "The Azure region for the VNet and subnet."
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group for the k8s and all resources managed by Terraform."
  type        = string
}

variable "node_vm_size" {
  description = "VM size for the default node pool."
  type        = string
  default     = "Standard_D2s_v5"
}

variable "subnet_id" {
  description = "ID of the subnet the AKS nodes are deployed into. Must have the NAT gateway association and Network Contributor role assignment in place before cluster creation."
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes minor version for the cluster, e.g. 1.31. Patch version is selected by AKS."
  type        = string
  default     = "1.31"
}

variable "pod_cidr" {
  type    = string
  default = "10.244.0.0/16"
}

variable "service_cidr" {
  type    = string
  default = "10.2.0.0/16"
}

variable "dns_service_ip" {
  type    = string
  default = "10.2.0.10"
}
