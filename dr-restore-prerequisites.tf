# ==============================================================================
# Phase 9 — DR Cluster Restore Prerequisites
#
# The AzureRM Terraform provider (v4.81.0) does NOT have a resource to trigger
# an AKS Backup restore operation. The actual restore must be performed via
# Azure Portal or Azure CLI.
#
# This file provisions the Terraform-managed prerequisites that the DR cluster
# (aks-lab-dr) must have before a restore can be initiated:
#   1. Backup Extension installed on the DR cluster
#   2. DR cluster identity → Contributor on the snapshot resource group
#   3. DR extension identity → Storage Blob Data Contributor on the storage account
#
# These are verified requirements from Microsoft's "Restore AKS using CLI" docs.
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. Backup Extension on the DR AKS cluster
#    Same extension type and storage configuration as the primary cluster's
#    extension, pointing to the same storage account and blob container where
#    backup data is stored.
# ------------------------------------------------------------------------------
resource "azurerm_kubernetes_cluster_extension" "dr_backup" {
  name           = "azure-aks-backup"
  cluster_id     = module.dr_aks.aks_cluster_id
  extension_type = "microsoft.dataprotection.kubernetes"
  release_train  = "stable"

  configuration_settings = {
    "credentials.tenantId"                                      = data.azurerm_client_config.current.tenant_id
    "configuration.backupStorageLocation.config.subscriptionId" = data.azurerm_client_config.current.subscription_id
    "configuration.backupStorageLocation.config.resourceGroup"  = azurerm_storage_account.backup.resource_group_name
    "configuration.backupStorageLocation.config.storageAccount" = azurerm_storage_account.backup.name
    "configuration.backupStorageLocation.bucket"                = azurerm_storage_container.backup.name
  }

  depends_on = [module.dr_aks]
}

# ------------------------------------------------------------------------------
# 2. DR AKS cluster identity → Contributor on the snapshot resource group
#    Required per Microsoft docs: "Target AKS cluster should have Contributor
#    role on the Snapshot Resource Group" for restore operations.
# ------------------------------------------------------------------------------
resource "azurerm_role_assignment" "dr_aks_contributor_on_snap_rg" {
  scope                = azurerm_resource_group.backup_snapshots.id
  role_definition_name = "Contributor"
  principal_id         = module.dr_aks.aks_cluster_identity_principal_id

  depends_on = [module.dr_aks]
}

# ------------------------------------------------------------------------------
# 3. DR Backup Extension identity → Storage Blob Data Contributor on the
#    storage account
#    Required per Microsoft docs: "The User Identity attached with the Backup
#    Extension should have Storage Blob Data Contributor roles on the storage
#    account where backups are stored" for Operational Tier restore.
# ------------------------------------------------------------------------------
resource "azurerm_role_assignment" "dr_extension_blob_data_contributor" {
  scope                = azurerm_storage_account.backup.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_kubernetes_cluster_extension.dr_backup.aks_assigned_identity[0].principal_id

  depends_on = [azurerm_kubernetes_cluster_extension.dr_backup]
}

# ------------------------------------------------------------------------------
# 4. DR Backup Extension identity → Storage Account Contributor
#    Required so the backup extension can retrieve the storage account access
#    keys used by the Backup Storage Location.
# ------------------------------------------------------------------------------
resource "azurerm_role_assignment" "dr_extension_storage_account_contributor" {
  scope                = azurerm_storage_account.backup.id
  role_definition_name = "Storage Account Contributor"
  principal_id         = azurerm_kubernetes_cluster_extension.dr_backup.aks_assigned_identity[0].principal_id

  depends_on = [azurerm_kubernetes_cluster_extension.dr_backup]
}