terraform {
  required_providers {
    azurerm = "~> 3.19.1"
  }
  backend "azurerm" { }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}
