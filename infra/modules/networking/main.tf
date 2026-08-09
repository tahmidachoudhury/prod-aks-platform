resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.address_space

  tags = {
    project_name = var.project_name
    environment  = var.environment
  }
}

resource "azurerm_subnet" "aks_nodes" {
  name                 = var.snet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.address_prefix_snet
}

resource "azurerm_network_security_group" "aks_nodes" {
  name                = "nsg-aks-nodes"
  resource_group_name = var.rg_name
  location            = var.location
  tags = {
    project_name = var.project_name
    environment  = var.environment
  }
}

resource "azurerm_subnet_network_security_group_association" "aks_nodes" {
  subnet_id                 = azurerm_subnet.aks_nodes.id
  network_security_group_id = azurerm_network_security_group.aks_nodes.id
}

resource "azurerm_network_security_rule" "allow_https" {
  # checkov:skip=CKV_AZURE_160
  # Come back to redirect traffic from http to https
  name                        = "AllowHTTPSInbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["80", "443"]
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.aks_nodes.name
}

resource "azurerm_network_security_rule" "allow_pod_cidr" {
  name                        = "AllowPodCidrInbound"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = var.pod_cidr
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.aks_nodes.name
}
