variable "cluster_name" {
  description = "Name of the AKS cluster ArgoCD is installed into."
  type        = string
}

variable "rg_name" {
  description = "Resource group containing the AKS cluster."
  type        = string
}

variable "argocd_chart_version" {
  description = "argo-cd Helm chart version. Pinned deliberately."
  type        = string
  default     = "7.7.5"
}

variable "gitops_repo_url" {
  description = "HTTPS URL of the repo ArgoCD watches."
  type        = string
}

variable "gitops_path" {
  description = "Path within the repo holding the child Application manifests."
  type        = string
  default     = "gitops/apps"
}

variable "gitops_revision" {
  description = "Branch or tag ArgoCD tracks."
  type        = string
  default     = "main"
}
