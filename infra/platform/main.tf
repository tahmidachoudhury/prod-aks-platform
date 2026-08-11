resource "azurerm_resource_group" "app" {
  name     = "rg-aks-platform-prod"
  location = var.location

  tags = {
    project_name = var.project_name
    environment  = var.environment
  }
}

module "networking" {
  source       = "./modules/networking"
  vnet_name    = "vnet-aks-platform"
  snet_name    = "snet-aks-nodes"
  project_name = var.project_name
  environment  = var.environment
  location     = var.location
  rg_name      = azurerm_resource_group.app.name
  pod_cidr     = var.pod_cidr
  # CIDR range for VNet - default to 10.1.0.0/16 because AKS defaults service CIDR to 10.0.0.0/16
  address_space = ["10.1.0.0/16"]
  # Subnet /22 gives headroom for any node pool scaling
  address_prefix_snet = ["10.1.0.0/22"]
}

module "kubernetes" {
  source       = "./modules/kubernetes"
  location     = var.location
  rg_name      = azurerm_resource_group.app.name
  subnet_id    = module.networking.vnet_subnet_id
  project_name = var.project_name
  environment  = var.environment
}

data "azurerm_container_registry" "main" {
  name                = var.acr_name
  resource_group_name = var.acr_resource_group_name
}

resource "azurerm_role_assignment" "kubelet_acr_pull" {
  principal_id                     = module.kubernetes.kubelet_identity_object_id
  role_definition_name             = "AcrPull"
  scope                            = data.azurerm_container_registry.main.id
  skip_service_principal_aad_check = true
}

module "dns" {
  source                   = "./modules/dns"
  oidc_issuer_url          = module.kubernetes.oidc_issuer_url
  external_dns_identity_id = var.external_dns_identity_id
}
