resource "azurerm_lb" "lb" {
  location            = azurerm_resource_group.rg.location
  name                = local.project_distinguisher
  resource_group_name = azurerm_resource_group.rg.name

  sku = "Standard"

  frontend_ip_configuration {
    name                          = "private_frontend_ip10"
    #availability_zone            = "Zone-Redundant"
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(azurerm_subnet.vip.address_prefix, 10 )
    subnet_id                     = azurerm_subnet.vip.id
    private_ip_address_version    = "IPv4"
  }
}

resource "azurerm_lb_rule" "example" {
  resource_group_name            = azurerm_resource_group.rg.name
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "TCP-8000"
  protocol                       = "Tcp"
  frontend_port                  = 8000
  backend_port                   = 8000
  frontend_ip_configuration_name = "private_frontend_ip10"
  probe_id                       = azurerm_lb_probe.tcp8000.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.mybackend.id

}


resource "azurerm_lb_backend_address_pool" "mybackend" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "mybackend"
}


resource "azurerm_lb_backend_address_pool_address" "lbbackend01" {
  name                    = "lbbackend01"
  backend_address_pool_id = azurerm_lb_backend_address_pool.mybackend.id
  virtual_network_id      = azurerm_virtual_network.vnet.id
  ip_address              = cidrhost(azurerm_subnet.backend.address_prefix, 10 )
}


resource "azurerm_lb_backend_address_pool_address" "lbbackend02" {
  name                    = "lbbackend02"
  backend_address_pool_id = azurerm_lb_backend_address_pool.mybackend.id
  virtual_network_id      = azurerm_virtual_network.vnet.id
  ip_address              = cidrhost(azurerm_subnet.backend.address_prefix, 11 )
}


resource "azurerm_lb_probe" "tcp8000" {
  resource_group_name = azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_lb.lb.id
  name                = "tcp-8000"
  port                = 8000
}