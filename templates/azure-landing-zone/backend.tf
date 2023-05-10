terraform {
  backend "azurerm" {
    storage_account_name = "#AZURE-BACKEND-STORAGE-ACCOUNT-NAME#"
    container_name       = "#AZURE-BACKEND-CONTAINER-NAME#"
    key                  = "terraform.tfstate"
    access_key = "#AZURE-BACKEND-ACCESS-KEY#"
  }
}
