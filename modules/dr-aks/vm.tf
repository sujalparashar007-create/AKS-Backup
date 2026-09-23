resource "azurerm_network_interface" "test" {
  name                = "nic-${var.test_vm_name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.aks.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = var.test_vm_name
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  size                = var.node_vm_size

  admin_username                  = "azureuser"
  admin_password                  = var.test_vm_admin_password
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.test.id,
  ]

  os_disk {
    name                 = "osdisk-${var.test_vm_name}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  tags = merge(var.tags, { Purpose = "Private AKS DR Testing" })
}

