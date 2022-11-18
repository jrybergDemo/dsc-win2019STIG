
data "azurerm_automation_account" "AutomationAccount" {
  name                = var.automation_account_name
  resource_group_name = data.azurerm_resource_group.automation.name
}

output "automation_account_id" { value = data.azurerm_automation_account.AutomationAccount.id }

resource "azurerm_virtual_machine_extension" "win_dsc" {
  depends_on                 = [azurerm_windows_virtual_machine.vm,data.azurerm_automation_account.AutomationAccount]
  name                       = "Microsoft.Powershell.DSC"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
  publisher                  = "Microsoft.Powershell"
  type                       = "DSC"
  type_handler_version       = "2.83"

  settings                   = <<SETTINGS
  {
    "WmfVersion": "latest",
    "Properties": {
      "RegistrationKey": {
        "UserName": "PLACEHOLDER_DONOTUSE",
        "Password": "PrivateSettingsRef:registrationKeyPrivate"
      },
      "RegistrationUrl":                "${data.azurerm_automation_account.AutomationAccount.endpoint}",
      "NodeConfigurationName":          "${var.dsc_node_configuration_name}",
      "RefreshFrequencyMins":           "30",
      "ConfigurationMode":              "ApplyandAutoCorrect",
      "ConfigurationModeFrequencyMins": "15",
      "RebootNodeIfNeeded":             true,
      "ActionAfterReboot":              "continueConfiguration",
      "AllowModuleOverwrite":           true
    }
  }
  SETTINGS

  protected_settings         = <<PROTECTED_SETTINGS
  {
    "Items": {
      "registrationKeyPrivate" : "${data.azurerm_automation_account.AutomationAccount.primary_key}"
    }
  }
  PROTECTED_SETTINGS
}

resource "azurerm_virtual_machine_extension" "create_cert" {
  name                 = "CreateCert"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
    {
      "fileUris": [
        "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/demos/vm-winrm-windows/ConfigureWinRM.ps1",
        "https://github.com/Azure/azure-quickstart-templates/blob/master/demos/vm-winrm-windows/makecert.exe?raw=true"
      ],
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File .\\ConfigureWinRM.ps1 \"${var.hostname_FQDN}\""
    }
  SETTINGS
}
