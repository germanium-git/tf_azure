variable "subscription_id" {}

# --Define locals to derive names of the resources to be deployed
locals {
  project_distinguisher = "nemedpet-routeserver"
  environment           = "internal_demo"
}

# --Define the location where to deploy the resources
variable "location" {
  default = "West Europe"
}

# --Network Security Group rules protecting the VM(s)
# --Allow SSH access from your IP addresses
variable "nsg_rules" {
  description = "Network Security Group"
  type = map(list(string))

  # Structure is as follows name = [priority, direction, access, protocol, source_port_range, destination_port_range, source_address_prefix, destination_address_prefix]
  default = {
    #allowall = ["100", "Inbound", "Allow", "*", "*", "*", "*", "*",]
    SSH   = ["110", "Inbound", "Allow", "Tcp", "*", "22", "185.230.172.74/32", "*",]
    AllVNETIn = ["100", "Inbound", "Allow", "*", "*", "*", "10.0.0.0/8", "*",]
    OutAll = ["100", "Outbound", "Allow", "*", "*", "*", "*", "*",]
  }
}

# --The Account to access VM(s)
variable "admin_username" {
  default = "azureuser"
}


# The path of the destination file on the virtual machine where the key will be written.
variable "keypath" {
  default = "/home/azureuser/.ssh/authorized_keys"
}

variable "pubkey" {
  default = "./key/id_rsa.pub"
}

