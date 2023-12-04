terraform {
  required_version = "~> 1.6.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.8.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-storage-rg"
    storage_account_name = "terraformstate202"
    container_name       = "terraformstatefiles"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {
  }
}


