provider "azurerm" {
  subscription_id = var.subscription_id
/*
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
*/
  features {}
}


# --Create vNet for source VM
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnetname
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = [var.vnetcidr]
}


# --Create subnet for RouteServer
resource "azurerm_subnet" "rutersubnet" {
  name                 = "RouteServerSubnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(var.vnetcidr, 11, 0)]
}


# --Create subnet1 for workloads
resource "azurerm_subnet" "subnet1" {
  name                 = "${var.vnetname}-subnet1"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(var.vnetcidr, 8, 1)]
}


# --Create subnet2 for workloads
resource "azurerm_subnet" "subnet2" {
  name                 = "${var.vnetname}-subnet2"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(var.vnetcidr, 8, 2)]
}

# --Create subnet3 for workloads
resource "azurerm_subnet" "subnet3" {
  name                 = "${var.vnetname}-subnet3"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(var.vnetcidr, 8, 3)]
}

# --Network Security Group
resource "azurerm_network_security_group" "nsg" {
    name                = "nsg-${var.vnetname}"
    location            = var.location
    resource_group_name = var.rg_name
}

# --Security rules for the Network Security Group
resource "azurerm_network_security_rule" "sec_rule" {
    for_each                    = var.nsg_rules
    resource_group_name         = var.rg_name
    network_security_group_name = azurerm_network_security_group.nsg.name
    name                        = each.key
    priority                    = each.value[0]
    direction                   = each.value[1]
    access                      = each.value[2]
    protocol                    = each.value[3]
    source_port_range           = each.value[4]
    destination_port_range      = each.value[5]
    source_address_prefix       = each.value[6]
    destination_address_prefix  = each.value[7]
}