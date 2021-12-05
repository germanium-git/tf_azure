
# --Storage account for staging files when VM is bei9ng restored
resource "azurerm_storage_account" "example" {
  name                     = "sa${local.storage_name}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = local.environment
  }
}