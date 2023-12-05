resource "azurerm_resource_group" "basic_resource_group" {
  name     = "resource_group_01"
  location = var.location
}
