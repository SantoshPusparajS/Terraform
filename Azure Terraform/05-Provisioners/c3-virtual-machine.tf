resource "azurerm_linux_virtual_machine" "linux-vm" {
  name                  = "demo-linux-vm"
  resource_group_name   = azurerm_resource_group.rg1.name
  location              = azurerm_resource_group.rg1.location
  size                  = "Standard_DS1_v2"
  admin_username        = "linuxuser"
  network_interface_ids = [azurerm_network_interface.ni-01.id]
  admin_ssh_key {
    username   = "linuxuser"
    public_key = file("${path.module}/ssh-file/terraform-azure.pub")
  }
  os_disk {
    name                 = "osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "87-gen2"
    version   = "latest"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip_address
    user        = self.admin_username
    private_key = file("${path.module}/ssh-file/terraform-azure.pem")
  }

  provisioner "file" {
    source = "/data/sample.txt"
    #content = "Hello World" ##We can also use the content to be displayed at dest path
    destination = "/tmp/sample.txt"
  }
}
