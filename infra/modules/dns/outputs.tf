output "external_dns_client_id" {
  description = "Client ID of the ExternalDNS managed identity."
  value       = azurerm_user_assigned_identity.external_dns.client_id
}
