output "routersubnet_id" {
  value = azurerm_subnet.rutersubnet.id
}

output "subnet1_id" {
  value = azurerm_subnet.subnet1.id
}

output "subnet1_cidr" {
  value = azurerm_subnet.subnet1.address_prefix
}

output "subnet2_id" {
  value = azurerm_subnet.subnet2.id
}

output "subnet2_cidr" {
  value = azurerm_subnet.subnet2.address_prefix
}

output "subnet3_id" {
  value = azurerm_subnet.subnet3.id
}

output "subnet3_cidr" {
  value = azurerm_subnet.subnet3.address_prefix
}

output "nsg_id" {
  value = azurerm_network_security_group.nsg.id
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}