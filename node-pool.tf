resource "azurerm_kubernetes_cluster_node_pool" "apps" {
  name                  = "apps"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = "Standard_D2alds_v7"
  mode                  = "User"

  node_count           = 1
  min_count            = 1
  max_count            = 5
  auto_scaling_enabled = true

  vnet_subnet_id = azurerm_subnet.aks.id

  upgrade_settings {
    max_surge = "10%"
  }
}