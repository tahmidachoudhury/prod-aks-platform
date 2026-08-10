output "vnet_subnet_id" {
  description = "The id of the subnet from the VNet for the k8s cluster"
  value       = azurerm_subnet.aks_nodes.id
}
