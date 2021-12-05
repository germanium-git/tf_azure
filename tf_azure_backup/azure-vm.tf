# --Create NIC with public IP
resource "azurerm_network_interface" "nic" {
    name                      = "nic-${local.project_distinguisher}"
    location                  = var.location
    resource_group_name       = azurerm_resource_group.rg.name

    ip_configuration {
        name                          = "nic-10th-priv-ipaddress"
        subnet_id                     = azurerm_subnet.subnet.id
        private_ip_address_allocation = "Static"
        private_ip_address            = cidrhost(azurerm_subnet.subnet.address_prefix, 10 )
        public_ip_address_id          = azurerm_public_ip.pip01.id
    }
}


# --Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nic" {
    network_interface_id      = azurerm_network_interface.nic.id
    network_security_group_id = azurerm_network_security_group.nsg.id
}

# --Create a public IP
resource "azurerm_public_ip" "pip01" {
  name = "pip-01"
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method = "Dynamic"
  sku = "Basic"
}


# --Create VM Ubuntu 16.04.0 LTS
resource "azurerm_virtual_machine" "ubuntu16-04" {
    name                    = "vm-${local.project_distinguisher}"
    location                = var.location
    resource_group_name     = azurerm_resource_group.rg.name
    network_interface_ids   = [azurerm_network_interface.nic.id]
    vm_size                 = "Standard_DS1_v2"
    delete_os_disk_on_termination = true

    storage_os_disk {
        name                = "osdisk-vm-${local.project_distinguisher}"
        caching             = "ReadWrite"
        create_option       = "FromImage"
        managed_disk_type   = "Premium_LRS"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04.0-LTS"
        version   = "latest"
    }

    os_profile {
        computer_name  = "vm-${local.project_distinguisher}"
        admin_username = var.admin_username
    }

    os_profile_linux_config {
        disable_password_authentication = true
        ssh_keys {
            path     = var.keypath
            key_data = file(var.pubkey)
        }
    }
}

output "public-ip-ubuntu16-04" {
    value = azurerm_public_ip.pip01.ip_address
}


# --Create NIC with public IP
resource "azurerm_network_interface" "nic-win" {
    name                      = "nic-win-${local.project_distinguisher}"
    location                  = var.location
    resource_group_name       = azurerm_resource_group.rg.name

    ip_configuration {
        name                          = "nic-11th-priv-ipaddress"
        subnet_id                     = azurerm_subnet.subnet.id
        private_ip_address_allocation = "Static"
        private_ip_address            = cidrhost(azurerm_subnet.subnet.address_prefix, 11 )
        public_ip_address_id          = azurerm_public_ip.pip02.id
    }
}


# --Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nic-win" {
    network_interface_id      = azurerm_network_interface.nic-win.id
    network_security_group_id = azurerm_network_security_group.nsg.id
}

# --Create a public IP
resource "azurerm_public_ip" "pip02" {
  name = "pip-02"
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method = "Dynamic"
  sku = "Basic"
}


# --Create VM Win2019
resource "azurerm_windows_virtual_machine" "win2019" {
  name                  = "win-${local.project_distinguisher}"
  computer_name         = "winvm"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = "Standard_DS1_v2"
  admin_username        = "adminuser"
  admin_password        = "hfgh5dhsttFrwgW2as"
  network_interface_ids = [
    azurerm_network_interface.nic-win.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}


output "public-ip-win-2019" {
    value = azurerm_public_ip.pip02.ip_address
}




