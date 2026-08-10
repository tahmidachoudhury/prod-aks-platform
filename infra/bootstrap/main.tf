resource "azurerm_resource_group" "main" {
  name     = "bootstrap-resources"
  location = "UK South"
}

resource "azurerm_container_registry" "main" {
  name                = "acrtahmidaks"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = false
  tags = {
    project_name = var.project_name
  }
}

data "azurerm_dns_zone" "main" {
  name                = var.dns_zone_name
  resource_group_name = var.rg_dns_name
}

data "azurerm_resource_group" "dns" {
  name = var.rg_dns_name
}

resource "azurerm_user_assigned_identity" "external_dns" {
  name                = "id-external-dns"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  tags = {
    project_name = var.project_name
    environment  = var.environment
  }
}

resource "azurerm_role_assignment" "external_dns_zone" {
  scope                = data.azurerm_dns_zone.main.id
  role_definition_name = "DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.external_dns.principal_id
}

resource "azurerm_role_assignment" "external_dns_rg_reader" {
  scope                = data.azurerm_resource_group.dns.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.external_dns.principal_id
}
