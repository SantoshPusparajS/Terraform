module "vnet" {
  source  = "Azure/vnet/azurerm"
  version = "4.1.0"

  resource_group_name = azurerm_resource_group.basic_resource_group.name
  vnet_name           = "basic-vnet"
  vnet_location       = var.vnet_location
  address_space       = ["10.0.0.0/16"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  use_for_each        = var.use_for_each

  subnet_service_endpoints = {
    subnet2 = ["Microsoft.Storage", "Microsoft.Sql"],
    subnet3 = ["Microsoft.AzureActiveDirectory"]
  }

  tags = {
    environment = "dev"
  }
  depends_on = [azurerm_resource_group.basic_resource_group]
}
