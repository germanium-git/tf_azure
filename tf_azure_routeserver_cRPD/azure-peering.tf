resource "azurerm_virtual_network_peering" "hub1-hub2" {
  name                      = "hub1-to-hub2"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = module.hub1.vnet_name
  remote_virtual_network_id = module.hub2.vnet_id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true
}

resource "azurerm_virtual_network_peering" "hub2-hub1" {
  name                      = "hub2-to-hub1"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = module.hub2.vnet_name
  remote_virtual_network_id = module.hub1.vnet_id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true
}

resource "azurerm_virtual_network_peering" "hub1-spoke1" {
  name                      = "hub1-to-spoke1"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = module.hub1.vnet_name
  remote_virtual_network_id = module.spoke1.vnet_id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true
}

resource "azurerm_virtual_network_peering" "spoke1-hub1" {
  name                      = "spoke1-to-hub1"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = module.spoke1.vnet_name
  remote_virtual_network_id = module.hub1.vnet_id
  allow_forwarded_traffic   = true
  use_remote_gateways       = false
  #use_remote_gateways       = true  - hub1 doesn't have ARS yet resulting in an error
}

resource "azurerm_virtual_network_peering" "hub1-spoke2" {
  name                      = "hub1-to-spoke2"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = module.hub1.vnet_name
  remote_virtual_network_id = module.spoke2.vnet_id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true
}

resource "azurerm_virtual_network_peering" "spoke2-hub1" {
  name                      = "spoke2-to-hub1"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = module.spoke2.vnet_name
  remote_virtual_network_id = module.hub1.vnet_id
  allow_forwarded_traffic   = true
  use_remote_gateways       = false
  #use_remote_gateways       = true - hub1 doesn't have ARS yet resulting in an error
}

resource "azurerm_virtual_network_peering" "hub2-spoke11" {
  name                      = "hub2-to-spoke11"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = module.hub2.vnet_name
  remote_virtual_network_id = module.spoke11.vnet_id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true
}

resource "azurerm_virtual_network_peering" "spoke11-hub2" {
  name                      = "spoke11-to-hub2"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = module.spoke11.vnet_name
  remote_virtual_network_id = module.hub2.vnet_id
  allow_forwarded_traffic   = true
  use_remote_gateways       = false
  #use_remote_gateways       = true - hub2 doesn't have ARS yet resulting in an error
}

resource "azurerm_virtual_network_peering" "hub2-spoke12" {
  name                      = "hub2-to-spoke12"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = module.hub2.vnet_name
  remote_virtual_network_id = module.spoke12.vnet_id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true
}

resource "azurerm_virtual_network_peering" "spoke12-hub2" {
  name                      = "spoke12-to-hub2"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = module.spoke12.vnet_name
  remote_virtual_network_id = module.hub2.vnet_id
  allow_forwarded_traffic   = true
  use_remote_gateways       = false
  #use_remote_gateways       = true - hub2 doesn't have ARS yet resulting in an error
}


