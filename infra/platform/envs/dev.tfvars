# In production this would never be used, only for demo/project purposes

environment = "dev"

dns_zone_name = "azure.tahmidchoudhury.uk"

rg_name = "rg-2048-aks-tf"

project_name = "prod-2048-aks-app"

location = "uksouth"

external_dns_identity_id = "/subscriptions/b61b10b2-15e4-43e2-8bd9-95a554e2249d/resourceGroups/bootstrap-resources/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-external-dns"