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
