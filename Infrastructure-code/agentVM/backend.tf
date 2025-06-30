    terraform {
      backend "azurerm" {
        storage_account_name = "tfstate6475"
        container_name       = "statefiles"
        key                  = "vm.tfstate"
      }
    }