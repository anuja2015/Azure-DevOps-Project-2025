terraform {
  backend "azurerm" {
    resource_group_name = "tfstate-RG"
    storage_account_name = "tfstate29894"
    container_name = "statefiles"
    key = "papergrid.terraform.state"
    
  }
}