output "oidc_issuer_url" {
  description = "OIDC issuer URL for the cluster. This is for k8s service accounts like externalDNS to exchange tokens for entra ID access."
  value       = azurerm_kubernetes_cluster.main.oidc_issuer_url
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.main.name
}

output "kubelet_identity_object_id" {
  description = "Object ID of the kubelet identity. Requires AcrPull on the registry to pull images."
  value       = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
}
