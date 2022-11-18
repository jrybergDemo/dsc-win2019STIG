variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the Automation Account exists.."
}

variable "location" {
  type        = string
  description = "The Azure Location of the resource group in which the Automation Account exists."
}

variable "automation_account_name" {
  type        = string
  description = "The name of the Azure Automation Account to deploy PowerSTIG 4.7.0 Modules into."
}