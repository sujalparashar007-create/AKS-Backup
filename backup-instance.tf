resource "azurerm_data_protection_backup_instance_kubernetes_cluster" "aks" {
  name                         = var.backup_instance_name
  location                     = var.location
  vault_id                     = azurerm_data_protection_backup_vault.aks.id
  kubernetes_cluster_id        = azurerm_kubernetes_cluster.aks.id
  snapshot_resource_group_name = azurerm_resource_group.backup_snapshots.name
  backup_policy_id             = azurerm_data_protection_backup_policy_kubernetes_cluster.aks.id

  backup_datasource_parameters {
    included_namespaces              = var.backup_included_namespaces
    excluded_namespaces              = []
    included_resource_types          = []
    excluded_resource_types          = []
    label_selectors                  = []
    cluster_scoped_resources_enabled = false
    volume_snapshot_enabled          = true
  }

  depends_on = [
    azurerm_kubernetes_cluster_extension.backup,
    azurerm_kubernetes_cluster_trusted_access_role_binding.backup,
    azurerm_role_assignment.backup_vault_reader_on_cluster,
    azurerm_role_assignment.backup_vault_reader_on_snap_rg,
    azurerm_role_assignment.aks_cluster_contributor_on_snap_rg,
    azurerm_role_assignment.extension_storage_account_contributor,
  ]
}

