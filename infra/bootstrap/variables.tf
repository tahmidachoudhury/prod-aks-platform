variable "project_name" {
  description = "The name of the project. Used as a prefix for all resource names."
  type        = string
  default     = "prod-2048-aks-app"
}

variable "subscription_id" {
  type        = string
  description = "Azure Account Identifier"
}
