#Wait for 90seconds after creating the Azure Virtual Machine Instances
resource "time_sleep" "wait_seconds" {
  create_duration = "90s"
  depends_on      = [azurerm_linux_virtual_machine.linux-vm]
}

#null resource will start after the time provider completed
resource "null_resource" "sync_app_content" {
  depends_on = [time_sleep.wait_seconds]
  triggers = {
    always-update = timestamp() #whenever we are running terraform apply command. Mainly used to have
    #static contents to display
  }
  connection {
    type        = "ssh"
    host        = azurerm_linux_virtual_machine.linux-vm.public_ip_address
    user        = azurerm_linux_virtual_machine.linux-vm.admin_username
    private_key = file("${path.module}/ssh-file/terraform-azure.pem")
  }

  #file provisioner
  provisioner "file" {
    source = "data/sample.txt"
    #content = "Hello World" ##We can also use the content to be displayed at dest path
    destination = "/tmp/sample.txt" #remote destination
    #on_failure = continue/fail
  }
  #remote-exec provisioner
  provisioner "remote-exec" {
    inline = [
      "sleep 120",
      "sudo mkdir /apps",
      "sudo cp /tmp/sample.txt /apps"
    ]
  }
  provisioner "local-exec" {
    when        = create
    command     = "echo ${azurerm_linux_virtual_machine.linux-vm.public_ip_address} >> creation-time.txt"
    working_dir = "outputs/"
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "echo Destroyed at %DATE% >> destruction-time.txt"
    working_dir = "outputs/"
  }
}
