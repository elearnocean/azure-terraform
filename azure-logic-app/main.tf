# Azure resource group creation
resource "azurerm_resource_group" "logic_app_rg" {
  count = var.create_resource_group ? 1 : 0
  name  = var.resource_group_name
  location = var.location
}

# Enable Application Insights 
resource "azurerm_application_insights" "logic_app_ai" {
  name                = "${var.logic_app_name}-appinsights"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
}

# Storage Account to store workflow states
resource "azurerm_storage_account" "logic_app_sa" {
  count                    = var.create_storage_account ? 1 : 0
  name                     = var.storage_account_name != null ? var.storage_account_name : "${var.logic_app_name}sa"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Logic App Service Plan
resource "azurerm_app_service_plan" "logic_app_plan" {
  name                = "${var.logic_app_name}-service-plan"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    tier = "Standard"
    size = "var.service_plan_size"
  }
}

# Logic App Creation
resource "azurerm_logic_app_standard" "logic_app" {
  name                       = var.logic_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = azurerm_app_service_plan.logic_app_plan.id
  storage_account_name       = var.create_storage_account ? azurerm_storage_account.logic_app_sa[0].name : var.storage_account_name
  storage_account_access_key = var.create_storage_account ? azurerm_storage_account.logic_app_sa[0].primary_access_key : var.storage_account_access_key

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"      = var.worker_runtime
    "WEBSITE_NODE_DEFAULT_VERSION"  = var.node_version
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.logic_app_ai.connection_string
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = azurerm_application_insights.logic_app_ai.instrumentation_key
  }

}

# Deploy Sample Workflow
resource "azurerm_logic_app_workflow" "workflow" {
  name                = "${var.logic_app_name}-workflow"
  resource_group_name = var.resource_group_name
  location            = var.location
  logic_app_integration_account_id  = azurerm_logic_app_standard.logic_app.id

  workflow_schema = fileexists(var.workflow_file) ? file(var.workflow_file) : file("${path.module}/workflows/default_workflow.json")
}
