output "acr_id" { value = azurerm_container_registry.main.id }

output "acr_login_server" { value = azurerm_container_registry.main.login_server }

output "external_dns_identity_id" {
  description = "Resource ID of the ExternalDNS identity. Consumed by the platform stack for the federated credential."
  value       = azurerm_user_assigned_identity.external_dns.id
}

output "external_dns_client_id" {
  description = "Client ID for the azure.workload.identity/client-id annotation. Stable across cluster rebuilds."
  value       = azurerm_user_assigned_identity.external_dns.client_id
}
