# --Create vNet HUB1
module "hub1" {
  source            = "./modules/vnet"
  location          = var.location
  subscription_id   = var.subscription_id
  rg_name           = azurerm_resource_group.rg.name
  vnetname          = "hub1"
  vnetcidr          = "10.0.0.0/16"
  nsg_rules         = var.nsg_rules
}

# --Create vNet HUB2
module "hub2" {
  source            = "./modules/vnet"
  location          = var.location
  subscription_id   = var.subscription_id
  rg_name           = azurerm_resource_group.rg.name
  vnetname          = "hub2"
  vnetcidr          = "10.10.0.0/16"
  nsg_rules         = var.nsg_rules
}

# --Create vNet Spoke1
module "spoke1" {
  source            = "./modules/vnet"
  location          = var.location
  subscription_id   = var.subscription_id
  rg_name           = azurerm_resource_group.rg.name
  vnetname          = "spoke1"
  vnetcidr          = "10.1.0.0/16"
  nsg_rules         = var.nsg_rules
}

# --Create vNet Spoke2
module "spoke2" {
  source            = "./modules/vnet"
  location          = var.location
  subscription_id   = var.subscription_id
  rg_name           = azurerm_resource_group.rg.name
  vnetname          = "spoke2"
  vnetcidr          = "10.2.0.0/16"
  nsg_rules         = var.nsg_rules
}

# --Create vNet Spoke11
module "spoke11" {
  source            = "./modules/vnet"
  location          = var.location
  subscription_id   = var.subscription_id
  rg_name           = azurerm_resource_group.rg.name
  vnetname          = "spoke11"
  vnetcidr          = "10.11.0.0/16"
  nsg_rules         = var.nsg_rules
}

# --Create vNet Spoke12
module "spoke12" {
  source            = "./modules/vnet"
  location          = var.location
  subscription_id   = var.subscription_id
  rg_name           = azurerm_resource_group.rg.name
  vnetname          = "spoke12"
  vnetcidr          = "10.12.0.0/16"
  nsg_rules         = var.nsg_rules
}