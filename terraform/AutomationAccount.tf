resource "azurerm_automation_account" "AutomationAccount" {
  name                          = var.automation_account_name
  location                      = data.azurerm_resource_group.automation.location
  resource_group_name           = data.azurerm_resource_group.automation.name
  sku_name                      = "Basic" # only Basic is supported at this time.
  public_network_access_enabled = true

  identity {
    type = "SystemAssigned"
  }
}

module "PowerStigModuleDeployment" {
  source                  = "./powerstig_module/PowerSTIG_4_11_0"
  resource_group_name     = data.azurerm_resource_group.automation.name
  automation_account_name = var.automation_account_name
  location                = data.azurerm_resource_group.automation.location
}
