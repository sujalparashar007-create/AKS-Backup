resource "azurerm_public_ip" "nat" {
  name                = var.nat_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.nat_public_ip_allocation_method
  sku                 = var.nat_gateway_sku

  tags = var.tags
}

resource "azurerm_nat_gateway" "aks" {
  name                    = var.nat_gateway_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = var.nat_gateway_sku
  idle_timeout_in_minutes = 4

  tags = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "aks" {
  nat_gateway_id       = azurerm_nat_gateway.aks.id
  public_ip_address_id = azurerm_public_ip.nat.id
}

resource "azurerm_subnet_nat_gateway_association" "aks" {
  subnet_id      = azurerm_subnet.aks.id
  nat_gateway_id = azurerm_nat_gateway.aks.id
}