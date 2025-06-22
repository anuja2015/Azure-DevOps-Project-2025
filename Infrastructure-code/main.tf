module "appservice" {
    source = "./appservice"
    resource_group_name = "papergrid-22062025_rg"
    location = "canadacentral"
    plan_name = "asp-linux-plan"
    webapp_name = "papergrid-22062025"
    slot_name = "staging"
  
}