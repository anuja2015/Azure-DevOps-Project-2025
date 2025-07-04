resource "azurerm_resource_group" "RG" {
  name = var.RESOURCE_GROUP_NAME
  location = "eastus"
  
}

resource "random_string" "resource_code" {

    length = 6
    special = false
    upper = false
}
resource "azurerm_storage_account" "tfstate" {

  name = "tfstate-${random_string.resource_code.result}"
  resource_group_name = azurerm_resource_group.RG.name
  location = azurerm_resource_group.RG.location
  account_tier = "Standard"
  account_replication_type = "GRS"

}