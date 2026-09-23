# ------------------------------------------------------------------------------
# Trusted Access binding: Backup Vault — DR AKS cluster
# Allows the Backup vault to communicate with the DR cluster for restore operations.
# ------------------------------------------------------------------------------
resource "azurerm_kubernetes_cluster_trusted_access_role_binding" "dr_backup" {
  kubernetes_cluster_id = module.dr_aks.aks_cluster_id
  name                  = "aksdrbackuptrustedaccess"
  source_resource_id    = azurerm_data_protection_backup_vault.aks.id
  roles                 = ["Microsoft.DataProtection/backupVaults/backup-operator"]

  depends_on = [module.dr_aks]
}

# ------------------------------------------------------------------------------
# Role assignment: Backup Vault MSI — Reader on the DR AKS cluster
# Allows the Backup vault to perform List and Read operations on the DR cluster
# for restore operations.
# ------------------------------------------------------------------------------
resource "azurerm_role_assignment" "backup_vault_reader_on_dr_cluster" {
  scope                = module.dr_aks.aks_cluster_id
  role_definition_name = "Reader"
  principal_id         = azurerm_data_protection_backup_vault.aks.identity[0].principal_id

  depends_on = [module.dr_aks]
}

