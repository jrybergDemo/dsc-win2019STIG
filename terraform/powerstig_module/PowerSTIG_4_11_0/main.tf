
resource "azurerm_resource_group_template_deployment" "ActiveDirectoryDsc" {
  name                = "ActiveDirectoryDsc_deployment_${substr(tostring(uuid()), 0, 8)}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/AutomationAccountModule.json")
  parameters_content = templatefile("${path.module}/AutomationAccountModule-Parameters.json",
    {
      automationAccountName = var.automation_account_name
      moduleName            = "ActiveDirectoryDsc"
      contentLink           = "https://www.powershellgallery.com/api/v2/package/ActiveDirectoryDsc/6.0.1"
      location              = var.location
    }
  )

  lifecycle {
    ignore_changes = [
      name,
      template_content
    ]
  }
}

resource "azurerm_resource_group_template_deployment" "AuditPolicyDsc" {
  name                = "AuditPolicyDsc_deployment_${substr(tostring(uuid()), 0, 8)}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/AutomationAccountModule.json")
  parameters_content = templatefile("${path.module}/AutomationAccountModule-Parameters.json",
    {
      automationAccountName = var.automation_account_name
      moduleName            = "AuditPolicyDsc"
      contentLink           = "https://www.powershellgallery.com/api/v2/package/AuditPolicyDsc/1.4.0"
      location              = var.location
    }
  )

  lifecycle {
    ignore_changes = [
      name,
      template_content
    ]
  }

  depends_on = [
    azurerm_resource_group_template_deployment.ActiveDirectoryDsc
  ]
}

resource "azurerm_resource_group_template_deployment" "AuditSystemDsc" {
  name                = "AuditSystemDsc_deployment_${substr(tostring(uuid()), 0, 8)}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/AutomationAccountModule.json")
  parameters_content = templatefile("${path.module}/AutomationAccountModule-Parameters.json",
    {
      automationAccountName = var.automation_account_name
      moduleName            = "AuditSystemDsc"
      contentLink           = "https://www.powershellgallery.com/api/v2/package/AuditSystemDsc/1.1.0"
      location              = var.location
    }
  )

  lifecycle {
    ignore_changes = [
      name,
      template_content
    ]
  }

  depends_on = [
    azurerm_resource_group_template_deployment.AuditPolicyDsc
  ]
}

resource "azurerm_resource_group_template_deployment" "AccessControlDsc" {
  name                = "AccessControlDsc_deployment_${substr(tostring(uuid()), 0, 8)}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/AutomationAccountModule.json")
  parameters_content = templatefile("${path.module}/AutomationAccountModule-Parameters.json",
    {
      automationAccountName = var.automation_account_name
      moduleName            = "AccessControlDsc"
      contentLink           = "https://www.powershellgallery.com/api/v2/package/AccessControlDsc/1.4.2"
      location              = var.location
    }
  )

  lifecycle {
    ignore_changes = [
      name,
      template_content
    ]
  }

  depends_on = [
    azurerm_resource_group_template_deployment.AuditSystemDsc
  ]
}

resource "azurerm_resource_group_template_deployment" "ComputerManagementDsc" {
  name                = "ComputerManagementDsc_deployment_${substr(tostring(uuid()), 0, 8)}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/AutomationAccountModule.json")
  parameters_content = templatefile("${path.module}/AutomationAccountModule-Parameters.json",
    {
      automationAccountName = var.automation_account_name
      moduleName            = "ComputerManagementDsc"
      contentLink           = "https://www.powershellgallery.com/api/v2/package/ComputerManagementDsc/8.4.0"
      location              = var.location
    }
  )

  lifecycle {
    ignore_changes = [
      name,
      template_content
    ]
  }

  depends_on = [
    azurerm_resource_group_template_deployment.AccessControlDsc
  ]
}

resource "azurerm_resource_group_template_deployment" "FileContentDsc" {
  name                = "FileContentDsc_deployment_${substr(tostring(uuid()), 0, 8)}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/AutomationAccountModule.json")
  parameters_content = templatefile("${path.module}/AutomationAccountModule-Parameters.json",
    {
      automationAccountName = var.automation_account_name
      moduleName            = "FileContentDsc"
      contentLink           = "https://www.powershellgallery.com/api/v2/package/FileContentDsc/1.3.0.151"
      location              = var.location
    }
  )

  lifecycle {
    ignore_changes = [
      name,
      template_content
    ]
  }

  depends_on = [
    azurerm_resource_group_template_deployment.ComputerManagementDsc
  ]
}

resource "azurerm_resource_group_template_deployment" "GPRegistryPolicyDsc" {
  name                = "GPRegistryPolicyDsc_deployment_${substr(tostring(uuid()), 0, 8)}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/AutomationAccountModule.json")
  parameters_content = templatefile("${path.module}/AutomationAccountModule-Parameters.json",
    {
      automationAccountName = var.automation_account_name
      moduleName            = "GPRegistryPolicyDsc"
      contentLink           = "https://www.powershellgallery.com/api/v2/package/GPRegistryPolicyDsc/1.2.0"
      location              = var.location
    }
  )

  lifecycle {
    ignore_changes = [
      name,
      template_content
    ]
  }

  depends_on = [
    azurerm_resource_group_template_deployment.FileContentDsc
  ]
}

resource "azurerm_resource_group_template_deployment" "PSDscResources" {
  name                = "PSDscResources_deployment_${substr(tostring(uuid()), 0, 8)}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/AutomationAccountModule.json")
  parameters_content = templatefile("${path.module}/AutomationAccountModule-Parameters.json",
    {
      automationAccountName = var.automation_account_name
      moduleName            = "PSDscResources"
      contentLink           = "https://www.powershellgallery.com/api/v2/package/PSDscResources/2.12.0"
      location              = var.location
    }
  )

  lifecycle {
    ignore_changes = [
      name,
      template_content
    ]
  }

  depends_on = [
    azurerm_resource_group_template_deployment.GPRegistryPolicyDsc
  ]
}

resource "azurerm_resource_group_template_deployment" "SecurityPolicyDsc" {
  name                = "SecurityPolicyDsc_deployment_${substr(tostring(uuid()), 0, 8)}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/AutomationAccountModule.json")
  parameters_content = templatefile("${path.module}/AutomationAccountModule-Parameters.json",
    {
      automationAccountName = var.automation_account_name
      moduleName            = "SecurityPolicyDsc"
      contentLink           = "https://www.powershellgallery.com/api/v2/package/SecurityPolicyDsc/2.10.0"
      location              = var.location
    }
  )

  lifecycle {
    ignore_changes = [
      name,
      template_content
    ]
  }

  depends_on = [
    azurerm_resource_group_template_deployment.PSDscResources
  ]
}

resource "azurerm_resource_group_template_deployment" "StorageDsc" {
  name                = "StorageDsc_deployment_${substr(tostring(uuid()), 0, 8)}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/AutomationAccountModule.json")
  parameters_content = templatefile("${path.module}/AutomationAccountModule-Parameters.json",
    {
      automationAccountName = var.automation_account_name
      moduleName            = "StorageDsc"
      contentLink           = "https://www.powershellgallery.com/api/v2/package/StorageDsc/5.0.1"
      location              = var.location
    }
  )

  lifecycle {
    ignore_changes = [
      name,
      template_content
    ]
  }

  depends_on = [
    azurerm_resource_group_template_deployment.SecurityPolicyDsc
  ]
}

resource "azurerm_resource_group_template_deployment" "SqlServerDsc" {
  name                = "SqlServerDsc_deployment_${substr(tostring(uuid()), 0, 8)}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/AutomationAccountModule.json")
  parameters_content = templatefile("${path.module}/AutomationAccountModule-Parameters.json",
    {
      automationAccountName = var.automation_account_name
      moduleName            = "SqlServerDsc"
      contentLink           = "https://www.powershellgallery.com/api/v2/package/SqlServerDsc/15.1.1"
      location              = var.location
    }
  )

  lifecycle {
    ignore_changes = [
      name,
      template_content
    ]
  }

  depends_on = [
    azurerm_resource_group_template_deployment.StorageDsc
  ]
}

resource "azurerm_resource_group_template_deployment" "WindowsDefenderDsc" {
  name                = "WindowsDefenderDsc_deployment_${substr(tostring(uuid()), 0, 8)}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/AutomationAccountModule.json")
  parameters_content = templatefile("${path.module}/AutomationAccountModule-Parameters.json",
    {
      automationAccountName = var.automation_account_name
      moduleName            = "WindowsDefenderDsc"
      contentLink           = "https://www.powershellgallery.com/api/v2/package/WindowsDefenderDsc/2.2.0"
      location              = var.location
    }
  )

  lifecycle {
    ignore_changes = [
      name,
      template_content
    ]
  }

  depends_on = [
    azurerm_resource_group_template_deployment.SqlServerDsc
  ]
}

resource "azurerm_resource_group_template_deployment" "xDnsServer" {
  name                = "xDnsServer_deployment_${substr(tostring(uuid()), 0, 8)}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/AutomationAccountModule.json")
  parameters_content = templatefile("${path.module}/AutomationAccountModule-Parameters.json",
    {
      automationAccountName = var.automation_account_name
      moduleName            = "xDnsServer"
      contentLink           = "https://www.powershellgallery.com/api/v2/package/xDnsServer/1.16.0"
      location              = var.location
    }
  )

  lifecycle {
    ignore_changes = [
      name,
      template_content
    ]
  }

  depends_on = [
    azurerm_resource_group_template_deployment.WindowsDefenderDsc
  ]
}

resource "azurerm_resource_group_template_deployment" "xWebAdministration" {
  name                = "xWebAdministration_deployment_${substr(tostring(uuid()), 0, 8)}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/AutomationAccountModule.json")
  parameters_content = templatefile("${path.module}/AutomationAccountModule-Parameters.json",
    {
      automationAccountName = var.automation_account_name
      moduleName            = "xWebAdministration"
      contentLink           = "https://www.powershellgallery.com/api/v2/package/xWebAdministration/3.2.0"
      location              = var.location
    }
  )

  lifecycle {
    ignore_changes = [
      name,
      template_content
    ]
  }

  depends_on = [
    azurerm_resource_group_template_deployment.xDnsServer
  ]
}

resource "azurerm_resource_group_template_deployment" "CertificateDsc" {
  name                = "CertificateDsc_deployment_${substr(tostring(uuid()), 0, 8)}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/AutomationAccountModule.json")
  parameters_content = templatefile("${path.module}/AutomationAccountModule-Parameters.json",
    {
      automationAccountName = var.automation_account_name
      moduleName            = "CertificateDsc"
      contentLink           = "https://www.powershellgallery.com/api/v2/package/CertificateDsc/5.0.0"
      location              = var.location
    }
  )

  lifecycle {
    ignore_changes = [
      name,
      template_content
    ]
  }

  depends_on = [
    azurerm_resource_group_template_deployment.xWebAdministration
  ]
}

resource "azurerm_resource_group_template_deployment" "nx" {
  name                = "nx_deployment_${substr(tostring(uuid()), 0, 8)}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/AutomationAccountModule.json")
  parameters_content = templatefile("${path.module}/AutomationAccountModule-Parameters.json",
    {
      automationAccountName = var.automation_account_name
      moduleName            = "nx"
      contentLink           = "https://www.powershellgallery.com/api/v2/package/nx/1.0.0"
      location              = var.location
    }
  )

  lifecycle {
    ignore_changes = [
      name,
      template_content
    ]
  }

  depends_on = [
    azurerm_resource_group_template_deployment.CertificateDsc
  ]
}

resource "azurerm_resource_group_template_deployment" "PowerSTIG" {
  name                = "PowerSTIG_deployment_${substr(tostring(uuid()), 0, 8)}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/AutomationAccountModule.json")
  parameters_content = templatefile("${path.module}/AutomationAccountModule-Parameters.json",
    {
      automationAccountName = var.automation_account_name
      moduleName            = "PowerSTIG"
      contentLink           = "https://www.powershellgallery.com/api/v2/package/PowerSTIG/4.11.0"
      location              = var.location
    }
  )

  lifecycle {
    ignore_changes = [
      name,
      template_content
    ]
  }

  depends_on = [
    azurerm_resource_group_template_deployment.ActiveDirectoryDsc,
    azurerm_resource_group_template_deployment.AuditPolicyDsc,
    azurerm_resource_group_template_deployment.AuditSystemDsc,
    azurerm_resource_group_template_deployment.AccessControlDsc,
    azurerm_resource_group_template_deployment.ComputerManagementDsc,
    azurerm_resource_group_template_deployment.FileContentDsc,
    azurerm_resource_group_template_deployment.GPRegistryPolicyDsc,
    azurerm_resource_group_template_deployment.PSDscResources,
    azurerm_resource_group_template_deployment.SecurityPolicyDsc,
    azurerm_resource_group_template_deployment.StorageDsc,
    azurerm_resource_group_template_deployment.SqlServerDsc,
    azurerm_resource_group_template_deployment.WindowsDefenderDsc,
    azurerm_resource_group_template_deployment.xDnsServer,
    azurerm_resource_group_template_deployment.xWebAdministration,
    azurerm_resource_group_template_deployment.CertificateDsc,
    azurerm_resource_group_template_deployment.nx
  ]
}
