terraform {
  required_version = ">= 1.9"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.35"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "prodaks2048tfstate"
    container_name       = "tfstate"
    key                  = "argocd.tfstate"
    use_azuread_auth     = true
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_kubernetes_cluster" "main" {
  name                = var.cluster_name
  resource_group_name = var.rg_name
}

locals {
  kube = data.azurerm_kubernetes_cluster.main.kube_config[0]
}

provider "helm" {
  kubernetes = {
    host                   = local.kube.host
    client_certificate     = base64decode(local.kube.client_certificate)
    client_key             = base64decode(local.kube.client_key)
    cluster_ca_certificate = base64decode(local.kube.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = local.kube.host
  client_certificate     = base64decode(local.kube.client_certificate)
  client_key             = base64decode(local.kube.client_key)
  cluster_ca_certificate = base64decode(local.kube.cluster_ca_certificate)
}
