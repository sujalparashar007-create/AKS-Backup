resource "azurerm_kubernetes_cluster_extension" "backup" {
  name           = "azure-aks-backup"
  cluster_id     = azurerm_kubernetes_cluster.aks.id
  extension_type = "microsoft.dataprotection.kubernetes"
  release_train  = "stable"

  configuration_settings = {
    "credentials.tenantId"                                      = data.azurerm_client_config.current.tenant_id
    "configuration.backupStorageLocation.config.subscriptionId" = data.azurerm_client_config.current.subscription_id
    "configuration.backupStorageLocation.config.resourceGroup"  = azurerm_storage_account.backup.resource_group_name
    "configuration.backupStorageLocation.config.storageAccount" = azurerm_storage_account.backup.name
    "configuration.backupStorageLocation.bucket"                = azurerm_storage_container.backup.name
  }
}

resource "azurerm_kubernetes_cluster_trusted_access_role_binding" "backup" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  name                  = "aksbackuptrustedaccess"
  source_resource_id    = azurerm_data_protection_backup_vault.aks.id
  roles                 = ["Microsoft.DataProtection/backupVaults/backup-operator"]

  depends_on = [azurerm_kubernetes_cluster_extension.backup]
}
