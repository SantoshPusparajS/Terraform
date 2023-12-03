terraform {
  required_version = "~> 1.6.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.8.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.2"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9.2"
    }
  }
}

provider "azurerm" {
  features {
  }
}


