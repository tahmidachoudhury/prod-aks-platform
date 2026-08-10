# I decided to keep the cluster to one system node pool, keeping costs low for a simple web app
# Optimising the size of the instance is important
# In the k8s manifests, I will leverage ResourceQuotas and LimitRange per namespace. LimitRange will apply to any pod that forgets to declare one.

resource "azurerm_user_assigned_identity" "aks" {
  name                = "id-${var.cluster_name}"
  resource_group_name = var.rg_name
  location            = var.location
  tags = {
    project_name = var.project_name
    environment  = var.environment
  }
}

resource "azurerm_role_assignment" "aks_network" {
  scope                = var.subnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = var.cluster_name
  node_resource_group = "${var.rg_name}-nodes"
  sku_tier            = "Free"
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name                 = "system"
    vm_size              = var.node_vm_size
    vnet_subnet_id       = var.subnet_id
    auto_scaling_enabled = true
    min_count            = 1
    max_count            = 2
    os_disk_type         = "Managed"
    max_pods             = 50

    upgrade_settings {
      max_surge = "33%"
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks.id]
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "cilium" # Azure CNI powered by Cilium. I might need to drop this if the Cilium agent takes up too many resources
    network_data_plane  = "cilium"
    load_balancer_sku   = "standard"
    pod_cidr            = var.pod_cidr
    service_cidr        = var.service_cidr
    dns_service_ip      = var.dns_service_ip
  }

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  tags = {
    project_name = var.project_name
    environment  = var.environment
  }

  depends_on = [
    azurerm_role_assignment.aks_network,
  ]

  lifecycle {
    ignore_changes = [default_node_pool[0].node_count]
  }

  node_provisioning_profile { mode = "Manual" }
}
