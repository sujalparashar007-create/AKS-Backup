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