Commands to create pem file:
ssh-keygen -m PEM -t rsa -b 4096 -C "azureuser@myserver" -f terraform-azure.pem

Command used to ssh into linuxvm using pem file:
ssh -i terraform-azure.pem linuxuser@20.25.55.39

Change the permissions of the pem file from properties->security