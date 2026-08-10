resource "azurerm_federated_identity_credential" "external_dns" {
  name                      = "external-dns"
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = var.oidc_issuer_url
  user_assigned_identity_id = var.external_dns_identity_id
  subject                   = "system:serviceaccount:external-dns:external-dns"
}
