# ------------------------------------------------------------------------------
# Role #1: Backup Vault MSI — Reader on the AKS cluster
# Allows the Backup vault to perform List and Read operations on the cluster.
# ------------------------------------------------------------------------------
resource "azurerm_role_assignment" "backup_vault_reader_on_cluster" {
  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Reader"
  principal_id         = azurerm_data_protection_backup_vault.aks.identity[0].principal_id

  depends_on = [azurerm_data_protection_backup_vault.aks]
}

# ------------------------------------------------------------------------------
# Role #2: Backup Vault MSI — Reader on the snapshot resource group
# Allows the Backup vault to perform List and Read operations on the snapshot RG.
# ------------------------------------------------------------------------------
resource "azurerm_role_assignment" "backup_vault_reader_on_snap_rg" {
  scope                = azurerm_resource_group.backup_snapshots.id
  role_definition_name = "Reader"
  principal_id         = azurerm_data_protection_backup_vault.aks.identity[0].principal_id

  depends_on = [azurerm_data_protection_backup_vault.aks]
}

# ------------------------------------------------------------------------------
# Role #3: AKS cluster identity — Contributor on the snapshot resource group
# Allows the AKS cluster to store persistent volume snapshots in the RG.
# Uses the cluster's system-assigned identity (control-plane MSI), NOT the
# kubelet identity, per Microsoft's "Prerequisites for AKS backup" docs and
# the official Azure AVM Terraform module example.
# ------------------------------------------------------------------------------
resource "azurerm_role_assignment" "aks_cluster_contributor_on_snap_rg" {
  scope                = azurerm_resource_group.backup_snapshots.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id

  depends_on = [azurerm_kubernetes_cluster.aks]
}

# ------------------------------------------------------------------------------
# Role #4: Backup Extension identity — Storage Account Contributor on the
# storage account
# Allows the Backup Extension to manage backup data in the storage account.
# Uses aks_assigned_identity, the extension's system-assigned managed identity
# created in the AKS node resource group, per the azurerm provider docs.
# ------------------------------------------------------------------------------
resource "azurerm_role_assignment" "extension_storage_account_contributor" {
  scope                = azurerm_storage_account.backup.id
  role_definition_name = "Storage Account Contributor"
  principal_id         = azurerm_kubernetes_cluster_extension.backup.aks_assigned_identity[0].principal_id

  depends_on = [azurerm_kubernetes_cluster_extension.backup]
}
