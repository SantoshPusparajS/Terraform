#Creating resource group
resource "azurerm_resource_group" "rg1" {
  name     = "my-resource-group-1"
  location = "East US"
}

#creating virtual network
resource "azurerm_virtual_network" "vnet01" {
  name                = "sample-vnet-01"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = azurerm_resource_group.rg1.name
  tags = { #maps
    "created-by" = "Santosh Pusparaj"
  }
}

#creating subnet
resource "azurerm_subnet" "subnet01" {
  name                 = "sample-subnet-01"
  virtual_network_name = azurerm_virtual_network.vnet01.name
  resource_group_name  = azurerm_resource_group.rg1.name
  address_prefixes     = ["10.0.1.0/24"]
}

#creating public ip address
resource "azurerm_public_ip" "publicip01" {
  #meta-argument depends_on : used to create dependency between one resource to another resource
  depends_on          = [azurerm_virtual_network.vnet01, azurerm_subnet.subnet01]
  name                = "my-public-ip"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  allocation_method   = "Static"
}

#creating network interface
resource "azurerm_network_interface" "ni-01" {
  name                = "my-network-interface"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  ip_configuration {
    #block inside
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip01.id
  }
}
