data "azurerm_dns_zone" "main" {
  name                = var.dns_zone_name
  resource_group_name = var.rg_dns_name
}

data "azurerm_resource_group" "dns" {
  name = var.rg_dns_name
}

resource "azurerm_user_assigned_identity" "external_dns" {
  name                = "id-external-dns"
  resource_group_name = var.rg_name
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

resource "azurerm_federated_identity_credential" "external_dns" {
  name                      = "external-dns"
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = var.oidc_issuer_url
  user_assigned_identity_id = azurerm_user_assigned_identity.external_dns.id
  subject                   = "system:serviceaccount:external-dns:external-dns"
}
