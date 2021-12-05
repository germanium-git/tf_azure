provider "azurerm" {
  subscription_id = var.subscription_id
/*
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
*/
  features {}
}


# --Create NIC with public IP
resource "azurerm_network_interface" "nic1" {
    name                      = "nic1-${var.vmname}"
    location                  = var.location
    resource_group_name       = var.rg_name

    ip_configuration {
        name                          = "nic1-10th-priv-ipaddress"
        subnet_id                     = var.subnet_id
        private_ip_address_allocation = "Static"
        private_ip_address            = var.private_ip_address
        public_ip_address_id          = azurerm_public_ip.pip.id
    }
}


# --Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nic1" {
    network_interface_id      = azurerm_network_interface.nic1.id
    network_security_group_id = var.nsg_id
}

# --Create a public IP
resource "azurerm_public_ip" "pip" {
  name                  = "pip"
  location              = var.location
  resource_group_name   = var.rg_name
  allocation_method     = "Dynamic"
  sku                   = "Basic"
}


# --Create VM Ubuntu 16.04.0 LTS
resource "azurerm_virtual_machine" "ubuntu" {
    name                    = var.vmname
    location                = var.location
    resource_group_name     = var.rg_name
    network_interface_ids   = [azurerm_network_interface.nic1.id]
    vm_size                 = "Standard_DS1_v2"
    delete_os_disk_on_termination = true

    storage_os_disk {
        name                = "osdisk-${var.vmname}"
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
        computer_name  = var.vmname
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

output "public-ip" {
    value = azurerm_public_ip.pip.ip_address
}

