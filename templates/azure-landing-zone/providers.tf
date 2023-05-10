terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.97.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.0"
    }
  }
}

provider "azurerm" {
  features {}
  tenant_id       = "#AZURE-TENANT-ID#"
  subscription_id = "#AZURE-SUBSCRIPTION-ID#"
  client_id       = "#AZURE-CLIENT-ID#"
  client_secret   = "#AZURE-CLIENT-SECRET#"
}

provider "azuread" {

}
