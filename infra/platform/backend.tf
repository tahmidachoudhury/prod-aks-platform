terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "prodaks2048tfstate"
    container_name       = "tfstate"
    key                  = "aks-platform.tfstate"
    use_azuread_auth     = true
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}
}
