#Creating resource group
#for_each demo with map
resource "azurerm_resource_group" "rg" {
  for_each = {
    dcapps1 = "eastus"
    dcapps2 = "eastus2"
    dcapps3 = "westus"
  }
  name     = "${each.key}-resource-group"
  location = each.value
}

#creating resource group
#for_each demo with set

# resource "azurerm_resource_group" "rg" {
#   for_each = toset(["eastus", "eastus2", "westus"])
#   name     = "${each.key}-resource-group"
#   location = each.key
# }

#for_each chaining
#substituting the resources directly to each.key
#for_each = azurerm_network_interface.my-nic
