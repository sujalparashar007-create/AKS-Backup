resource "azurerm_linux_virtual_machine" "aks_test" {
  name                = "vm-aks-test"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_D2alds_v7"

  admin_username                  = "azureuser"
  admin_password                  = var.test_vm_admin_password
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.aks_test.id
  ]

  os_disk {
    name                 = "osdisk-aks-test"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  tags = {
    Environment = "Lab"
    Project     = "AKS"
    ManagedBy   = "Terraform"
    Purpose     = "Private AKS DNS Testing"
  }
}

resource "azurerm_network_interface" "aks_test" {
  name                = "nic-aks-test"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.aks.id
    private_ip_address_allocation = "Dynamic"
  }
}