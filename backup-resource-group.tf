resource "azurerm_resource_group" "backup_snapshots" {
  name     = var.backup_snapshot_rg_name
  location = var.location

  tags = var.tags
}