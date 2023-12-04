#Creating resource group
resource "azurerm_resource_group" "rg1" {
  name     = "my-resource-group-1"
  location = var.resource_location
}
