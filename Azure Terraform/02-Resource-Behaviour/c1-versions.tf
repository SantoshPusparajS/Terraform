terraform {
  required_version = "~> 1.6.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.8.0"
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


