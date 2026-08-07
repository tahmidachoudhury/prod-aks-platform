resource "azurerm_resource_group" "app" {
  name     = var.rg_name
  location = var.location
}

# module "networking" {
#   source              = "./modules/networking"
#   project_name        = var.project_name
#   environment         = var.environment
#   resource_group_name = azurerm_resource_group.app.name
# }
