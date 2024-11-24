module "logic_app_1" {
  source                 = "./azure-logic-app"
  logic_app_name         = "logic-app-1"
  resource_group_name    = "resource-group-1"
  create_resource_group  = false
  location               = "West Europe"
  create_storage_account = true
  service_plan_size      = "WS2"
}

module "logic_app_2" {
  source                 = "./azure-logic-app"
  logic_app_name         = "logic-app-2"
  resource_group_name    = "resource-group-2"
  create_resource_group  = false
  location               = "East US"
  create_storage_account = true
  service_plan_size      = "WS2"
}

module "logic_app_3" {
  source                 = "./azure-logic-app"
  logic_app_name         = "logic-app-3"
  resource_group_name    = "resource-group-3"
  create_resource_group  = false
  location               = "Central US"
  create_storage_account = false
  storage_account_name   = "existingstorageaccount"
  storage_account_access_key = "example-access-key"
  service_plan_size      = "WS2"
}
