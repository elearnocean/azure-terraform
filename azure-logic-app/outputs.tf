output "logic_app_id" {
  description = "The ID of the Logic App"
  value       = azurerm_logic_app_standard.logic_app.id
}

output "workflow_id" {
  description = "The ID of the Logic App Workflow"
  value       = azurerm_logic_app_workflow.workflow.id
}

output "application_insights_connection_string" {
  description = "The Application Insights connection string"
  value       = azurerm_application_insights.logic_app_ai.connection_string
}
