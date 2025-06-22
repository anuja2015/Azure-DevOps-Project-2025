resource "azurerm_resource_group" "rg" {
    name = var.resource_group_name
    location = var.location
  
}
resource "azurerm_service_plan" "asp" {
  name = var.plan_name
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name = "S1"
  os_type = "Linux"
  depends_on = [ azurerm_resource_group.rg ]
  
}

resource "azurerm_linux_web_app" "webapp" {
    name = var.webapp_name
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  service_plan_id = azurerm_service_plan.asp.id
  site_config {
    always_on = true
    }

    depends_on = [ azurerm_service_plan.asp ]
}

resource "azurerm_linux_web_app_slot" "stage" { 
    name = var.slot_name
  app_service_id  = azurerm_linux_web_app.webapp.id
  site_config {}
  
}