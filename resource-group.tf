resource "azurerm_resource_group" "aks" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = "Lab"
    Project     = "AKS"
    ManagedBy   = "Terraform"
  }
}