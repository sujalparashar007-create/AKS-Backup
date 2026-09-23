resource "azurerm_data_protection_backup_policy_kubernetes_cluster" "aks" {
  name                = var.backup_policy_name
  resource_group_name = var.resource_group_name
  vault_name          = azurerm_data_protection_backup_vault.aks.name

  backup_repeating_time_intervals = var.backup_schedule_intervals
  time_zone                       = var.backup_time_zone

  default_retention_rule {
    life_cycle {
      duration        = var.backup_default_retention_duration
      data_store_type = "OperationalStore"
    }
  }
}
