output "argocd_namespace" {
  description = "Namespace ArgoCD is installed into."
  value       = helm_release.argocd.namespace
}

output "argocd_initial_password_command" {
  description = "Command to retrieve the initial admin password."
  value       = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
}
