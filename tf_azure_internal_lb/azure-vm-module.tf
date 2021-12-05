module "vm-jump" {
  source             = "./modules/vm_with_publicip"
  location           = var.location
  vmname             = "lbtestvmjump"
  subnet_id          = azurerm_subnet.frontend.id
  private_ip_address = cidrhost(azurerm_subnet.frontend.address_prefix, 10 )
  rg_name            = azurerm_resource_group.rg.name
  nsg_id             = azurerm_network_security_group.nsg.id
  admin_username     = var.admin_username
  keypath            = var.keypath
  pubkey             = var.pubkey
  subscription_id    = var.subscription_id
}


module "vm-front" {
  source             = "./modules/vm_without_publicip"
  location           = var.location
  vmname             = "lbtestfront"
  subnet_id          = azurerm_subnet.frontend.id
  private_ip_address = cidrhost(azurerm_subnet.frontend.address_prefix, 11 )
  rg_name            = azurerm_resource_group.rg.name
  nsg_id             = azurerm_network_security_group.nsg.id
  admin_username     = var.admin_username
  keypath            = var.keypath
  pubkey             = var.pubkey
  subscription_id    = var.subscription_id
}

module "vm-back01" {
  source             = "./modules/vm_without_publicip"
  location           = var.location
  vmname             = "lbtestback01"
  subnet_id          = azurerm_subnet.backend.id
  private_ip_address = cidrhost(azurerm_subnet.backend.address_prefix, 10 )
  rg_name            = azurerm_resource_group.rg.name
  nsg_id             = azurerm_network_security_group.nsg.id
  admin_username     = var.admin_username
  keypath            = var.keypath
  pubkey             = var.pubkey
  subscription_id    = var.subscription_id
}


module "vm-back02" {
  source             = "./modules/vm_without_publicip"
  location           = var.location
  vmname             = "lbtestback02"
  subnet_id          = azurerm_subnet.backend.id
  private_ip_address = cidrhost(azurerm_subnet.backend.address_prefix, 11 )
  rg_name            = azurerm_resource_group.rg.name
  nsg_id             = azurerm_network_security_group.nsg.id
  admin_username     = var.admin_username
  keypath            = var.keypath
  pubkey             = var.pubkey
  subscription_id    = var.subscription_id
}

output "jump-public-ip" {
  value = module.vm-jump.public-ip
}