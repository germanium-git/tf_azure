# --Create resource group
resource "azurerm_resource_group" "rg" {
    name            = "rg-${local.project_distinguisher}"
    location        = var.location

    tags = {
        environment = local.environment
    }
}


# --Create vNet for source VM
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet1"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.vnetcidr]
}


# --Create subnet for workloads
resource "azurerm_subnet" "subnet" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet1]
}


# --Create vNet for restored VM
resource "azurerm_virtual_network" "vnet-restore" {
  name                = "vnet1-restore"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.vnetcidr]
}


# --Create subnet for restored workloads
resource "azurerm_subnet" "subnet-restore" {
  name                 = "subnet1-restore"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet-restore.name
  address_prefixes     = [var.subnet1]
}


# --Network Security Group
resource "azurerm_network_security_group" "nsg" {
    name                = "nsg-${local.project_distinguisher}"
    location            = var.location
    resource_group_name = azurerm_resource_group.rg.name
}

# --Security rules for the Network Security Group
resource "azurerm_network_security_rule" "sec_rule" {
    for_each                    = var.nsg_rules
    resource_group_name         = azurerm_resource_group.rg.name
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

