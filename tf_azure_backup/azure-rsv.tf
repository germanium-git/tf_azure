resource "azurerm_recovery_services_vault" "vault" {
  name                = "rsv-${local.project_distinguisher}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

  soft_delete_enabled = true
}

resource "azurerm_backup_policy_vm" "d23" {
  name                = "daily-backup-23"
  resource_group_name = azurerm_resource_group.rg.name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name

  retention_daily {
    count = 7
  }

  backup {
    frequency = "Daily"
    time      = "23:00"
  }
}

resource "azurerm_backup_protected_vm" "vm1" {
  resource_group_name = azurerm_resource_group.rg.name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name
  source_vm_id        = azurerm_virtual_machine.ubuntu16-04.id
  backup_policy_id    = azurerm_backup_policy_vm.d23.id
}


resource "azurerm_backup_protected_vm" "win01" {
  resource_group_name = azurerm_resource_group.rg.name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name
  source_vm_id        = azurerm_windows_virtual_machine.win2019.id
  backup_policy_id    = azurerm_backup_policy_vm.d23.id
}