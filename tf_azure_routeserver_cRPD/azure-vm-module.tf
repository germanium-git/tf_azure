module "crpd1" {
  source                    = "./modules/vm_ubuntu_pip_2nics"
  location                  = var.location
  vmname                    = "crpd1"
  outer_subnet_id           = module.hub1.subnet1_id
  inner_subnet_id           = module.hub1.subnet2_id
  outer_private_ip_address  = cidrhost(module.hub1.subnet1_cidr, 10 )
  inner_private_ip_address  = cidrhost(module.hub1.subnet2_cidr, 10 )
  rg_name                   = azurerm_resource_group.rg.name
  nsg_id                    = module.hub1.nsg_id
  admin_username            = var.admin_username
  keypath                   = var.keypath
  pubkey                    = var.pubkey
  subscription_id           = var.subscription_id
}

module "crpd2" {
  source                    = "./modules/vm_ubuntu_pip_2nics"
  location                  = var.location
  vmname                    = "crpd2"
  outer_subnet_id           = module.hub2.subnet1_id
  inner_subnet_id           = module.hub2.subnet2_id
  outer_private_ip_address  = cidrhost(module.hub2.subnet1_cidr, 10 )
  inner_private_ip_address  = cidrhost(module.hub2.subnet2_cidr, 10 )
  rg_name                   = azurerm_resource_group.rg.name
  nsg_id                    = module.hub2.nsg_id
  admin_username            = var.admin_username
  keypath                   = var.keypath
  pubkey                    = var.pubkey
  subscription_id           = var.subscription_id
}

module "vmspoke1" {
  source             = "./modules/vm_ubuntu_pip"
  location           = var.location
  vmname             = "spoke1"
  subnet_id          = module.spoke1.subnet1_id
  private_ip_address = cidrhost(module.spoke1.subnet1_cidr, 10 )
  rg_name            = azurerm_resource_group.rg.name
  nsg_id             = module.spoke1.nsg_id
  admin_username     = var.admin_username
  keypath            = var.keypath
  pubkey             = var.pubkey
  subscription_id    = var.subscription_id
}

module "vmspoke2" {
  source             = "./modules/vm_ubuntu_pip"
  location           = var.location
  vmname             = "spoke2"
  subnet_id          = module.spoke2.subnet1_id
  private_ip_address = cidrhost(module.spoke2.subnet1_cidr, 10 )
  rg_name            = azurerm_resource_group.rg.name
  nsg_id             = module.spoke2.nsg_id
  admin_username     = var.admin_username
  keypath            = var.keypath
  pubkey             = var.pubkey
  subscription_id    = var.subscription_id
}

module "vmspoke11" {
  source             = "./modules/vm_ubuntu_pip"
  location           = var.location
  vmname             = "spoke11"
  subnet_id          = module.spoke11.subnet1_id
  private_ip_address = cidrhost(module.spoke11.subnet1_cidr, 10 )
  rg_name            = azurerm_resource_group.rg.name
  nsg_id             = module.spoke11.nsg_id
  admin_username     = var.admin_username
  keypath            = var.keypath
  pubkey             = var.pubkey
  subscription_id    = var.subscription_id
}

module "vmspoke12" {
  source             = "./modules/vm_ubuntu_pip"
  location           = var.location
  vmname             = "spoke12"
  subnet_id          = module.spoke12.subnet1_id
  private_ip_address = cidrhost(module.spoke12.subnet1_cidr, 10 )
  rg_name            = azurerm_resource_group.rg.name
  nsg_id             = module.spoke12.nsg_id
  admin_username     = var.admin_username
  keypath            = var.keypath
  pubkey             = var.pubkey
  subscription_id    = var.subscription_id
}