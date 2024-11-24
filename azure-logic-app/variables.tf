variable "logic_app_name" {
  description = "The name of the Logic App"
  type        = string
}

variable "resource_group_name" {
  description = "The resource group for the Logic App"
  type        = string
}

variable "create_resource_group" {
  description = "Whether to create a new Resource Group"
  type        = bool
  default     = false
}

variable "location" {
  description = "The location of the Logic App"
  type        = string
}

variable "create_storage_account" {
  description = "Flag to determine if a new storage account should be created"
  type        = bool
  default     = true
}

variable "storage_account_name" {
  description = "The name of the storage account to use if not creating a new one"
  type        = string
  default     = null
}

variable "storage_account_access_key" {
  description = "The access key of the storage account if not creating a new one"
  type        = string
  default     = null
}

variable "service_plan_size" {
  description = "The size of the App Service Plan"
  type        = string
  default     = "WS2"
}

variable "worker_runtime" {
  description = "The runtime for the Logic App worker"
  type        = string
  default     = "node"
}

variable "node_version" {
  description = "The Node.js version for the Logic App"
  type        = string
  default     = "~18"
}

variable "workflow_file" {
  description = "Path to the custom workflow JSON file. If not provided, the default workflow will be used."
  type        = string
  default     = null
}
