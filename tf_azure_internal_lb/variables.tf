variable "subscription_id" {}

# --Define locals to derive names of the resources to be deployed
locals {
  project_distinguisher = "nemedpet-lb-internal"
  environment           = "internal_lb_demo"
}

# --Define the location where to deplpy the resources
variable "location" {
  default = "West Europe"
}

# --vNET CIDR range
variable "vnetcidr" {
  default = "172.16.0.0/16"
}

# --Workload subnet CIDR
variable "frontend" {
  default = "172.16.1.0/24"
}

variable "backend" {
  default = "172.16.2.0/24"
}

variable "vip_subnet" {
  default = "172.16.10.0/24"
}

# --Network Security Group rules protecting the VM(s)
variable "nsg_rules" {
  description = "Network Security Group"
  type = map(list(string))

  # Structure is as follows name = [priority, direction, access, protocol, source_port_range, destination_port_range, source_address_prefix, destination_address_prefix]
  default = {
    #allowall = ["100", "Inbound", "Allow", "*", "*", "*", "*", "*",]
    SSH   = ["110", "Inbound", "Allow", "Tcp", "*", "22", "185.230.172.74/32", "*",]
    RDP   = ["120", "Inbound", "Allow", "Tcp", "*", "3389", "185.230.172.74/32", "*",]
    SSH2  = ["130", "Inbound", "Allow", "Tcp", "*", "3389", "131.207.242.5/32", "*",]
    AllVNETIn = ["100", "Inbound", "Allow", "*", "*", "*", "172.16.0.0/12", "*",]
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

