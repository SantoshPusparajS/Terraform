resource "azurerm_linux_virtual_machine" "linux-vm" {
  count                 = 2
  name                  = "demo-linux-vm-${count.index}"
  resource_group_name   = azurerm_resource_group.rg1.name
  location              = azurerm_resource_group.rg1.location
  size                  = "Standard_DS1_v2"
  admin_username        = "linuxuser"
  network_interface_ids = [element(azurerm_network_interface.ni-01[*].id, count.index)]
  admin_ssh_key {
    username   = "linuxuser"
    public_key = file("${path.module}/ssh-file/terraform-azure.pub")
  }
  os_disk {
    name                 = "osdisk-${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "87-gen2"
    version   = "latest"
  }
}
