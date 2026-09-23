output "resource_group_name" {
  description = "Name of the DR resource group"
  value       = azurerm_resource_group.this.name
}

output "aks_cluster_id" {
  description = "ID of the DR AKS cluster"
  value       = azurerm_kubernetes_cluster.this.id
}

output "aks_cluster_name" {
  description = "Name of the DR AKS cluster"
  value       = azurerm_kubernetes_cluster.this.name
}

output "aks_cluster_identity_principal_id" {
  description = "Principal ID of the DR AKS cluster system-assigned identity"
  value       = azurerm_kubernetes_cluster.this.identity[0].principal_id
}

output "aks_subnet_id" {
  description = "ID of the DR AKS subnet"
  value       = azurerm_subnet.aks.id
}

output "test_vm_private_ip" {
  description = "Private IP address of the DR test VM"
  value       = azurerm_network_interface.test.private_ip_address
}

output "bastion_name" {
  description = "Name of the DR Bastion host"
  value       = azurerm_bastion_host.this.name
}

