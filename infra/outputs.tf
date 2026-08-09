# These output variables are for post-apply and Helm configs

output "cluster_name" {
  description = "AKS cluster name, for az aks get-credentials."
  value       = module.kubernetes.cluster_name
}

output "resource_group_name" {
  description = "Resource group holding the platform resources."
  value       = azurerm_resource_group.app.name
}

output "external_dns_client_id" {
  description = "Client ID for the azure.workload.identity/client-id annotation on the external-dns service account."
  value       = module.dns.external_dns_client_id
}

output "dns_zone_name" {
  description = "DNS zone for the ExternalDNS --domain-filter argument."
  value       = var.dns_zone_name
}
