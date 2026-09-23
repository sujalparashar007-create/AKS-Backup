output "resource_group_name" {
  description = "Name of the AKS resource group"
  value       = azurerm_resource_group.aks.name
}

output "resource_group_location" {
  description = "Azure region of the resource group"
  value       = azurerm_resource_group.aks.location
}

output "aks_test_vm_private_ip" {
  description = "Private IP of the AKS test VM"
  value       = azurerm_network_interface.aks_test.private_ip_address
}

output "backup_snapshot_resource_group_name" {
  description = "Name of the backup snapshot resource group"
  value       = azurerm_resource_group.backup_snapshots.name
}

output "backup_storage_account_name" {
  description = "Name of the backup storage account"
  value       = azurerm_storage_account.backup.name
}

output "backup_storage_container_name" {
  description = "Name of the backup storage container"
  value       = azurerm_storage_container.backup.name
}

output "backup_vault_id" {
  description = "ID of the Azure Backup vault for AKS"
  value       = azurerm_data_protection_backup_vault.aks.id
}

output "backup_vault_name" {
  description = "Name of the Azure Backup vault for AKS"
  value       = azurerm_data_protection_backup_vault.aks.name
}

output "backup_vault_identity_principal_id" {
  description = "Principal ID of the Backup vault system-assigned identity"
  value       = azurerm_data_protection_backup_vault.aks.identity[0].principal_id
}

output "aks_backup_extension_id" {
  description = "ID of the AKS Backup extension"
  value       = azurerm_kubernetes_cluster_extension.backup.id
}

output "aks_backup_trusted_access_binding_id" {
  description = "ID of the AKS Backup Trusted Access role binding"
  value       = azurerm_kubernetes_cluster_trusted_access_role_binding.backup.id
}

output "aks_backup_policy_id" {
  description = "ID of the AKS Backup policy"
  value       = azurerm_data_protection_backup_policy_kubernetes_cluster.aks.id
}

output "aks_backup_policy_name" {
  description = "Name of the AKS Backup policy"
  value       = azurerm_data_protection_backup_policy_kubernetes_cluster.aks.name
}

output "backup_vault_reader_on_cluster_role_assignment_id" {
  description = "ID of the role assignment granting Backup Vault Reader on the AKS cluster"
  value       = azurerm_role_assignment.backup_vault_reader_on_cluster.id
}

output "backup_vault_reader_on_snap_rg_role_assignment_id" {
  description = "ID of the role assignment granting Backup Vault Reader on the snapshot resource group"
  value       = azurerm_role_assignment.backup_vault_reader_on_snap_rg.id
}

output "aks_cluster_contributor_on_snap_rg_role_assignment_id" {
  description = "ID of the role assignment granting AKS cluster Contributor on the snapshot resource group"
  value       = azurerm_role_assignment.aks_cluster_contributor_on_snap_rg.id
}

output "extension_storage_account_contributor_role_assignment_id" {
  description = "ID of the role assignment granting Backup Extension Storage Account Contributor on the storage account"
  value       = azurerm_role_assignment.extension_storage_account_contributor.id
}

output "backup_instance_id" {
  description = "ID of the AKS Backup Instance"
  value       = azurerm_data_protection_backup_instance_kubernetes_cluster.aks.id
}

output "backup_instance_name" {
  description = "Name of the AKS Backup Instance"
  value       = azurerm_data_protection_backup_instance_kubernetes_cluster.aks.name
}

output "dr_resource_group_name" {
  description = "Name of the DR resource group"
  value       = module.dr_aks.resource_group_name
}

output "dr_aks_cluster_id" {
  description = "ID of the DR AKS cluster"
  value       = module.dr_aks.aks_cluster_id
}

output "dr_aks_cluster_name" {
  description = "Name of the DR AKS cluster"
  value       = module.dr_aks.aks_cluster_name
}

output "dr_aks_cluster_identity_principal_id" {
  description = "Principal ID of the DR AKS cluster system-assigned identity"
  value       = module.dr_aks.aks_cluster_identity_principal_id
}

output "dr_subnet_id" {
  description = "ID of the DR AKS subnet"
  value       = module.dr_aks.aks_subnet_id
}

output "dr_test_vm_private_ip" {
  description = "Private IP address of the DR test VM"
  value       = module.dr_aks.test_vm_private_ip
}

output "dr_bastion_name" {
  description = "Name of the DR Bastion host"
  value       = module.dr_aks.bastion_name
}

output "dr_backup_trusted_access_binding_id" {
  description = "ID of the Trusted Access role binding between the Backup Vault and the DR AKS cluster"
  value       = azurerm_kubernetes_cluster_trusted_access_role_binding.dr_backup.id
}

output "backup_vault_reader_on_dr_cluster_role_assignment_id" {
  description = "ID of the role assignment granting Backup Vault Reader on the DR AKS cluster"
  value       = azurerm_role_assignment.backup_vault_reader_on_dr_cluster.id
}