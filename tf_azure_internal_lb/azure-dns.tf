resource "azurerm_private_dns_zone" "privzone" {
  name                = "nemedpet.testinfra.net"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "test"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privzone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  registration_enabled  = true
}
