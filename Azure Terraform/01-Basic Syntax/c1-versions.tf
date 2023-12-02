terraform {
  required_version = "~> 1.6.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.8.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }
  }
}

provider "azurerm" {
  features {
    #we can leave empty as we authenticated via az login
    #will be useful if we are using service accoutn
    #used to override the default behaviour of any resources across the global level
  }
}

#multiple provider
provider "azurerm" {
  features {
    virtual_machine {
      delete_os_disk_on_deletion = false
    }
  }
  alias = "provider2-westus"
  #client_id =
  #subscription_id =
}

resource "azurerm_resource_group" "rg1" {
  name     = "my-resource-group-1"
  location = "East US"
}

resource "azurerm_resource_group" "rg2" {
  name     = "my-resource-group-2"
  location = "North Europe"
  provider = azurerm.provider2-westus #metaargument
}
