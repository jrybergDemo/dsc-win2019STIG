resource "azurerm_availability_set" "as" {
  name                  = var.availability_set_name
  location              = data.azurerm_resource_group.win2019.location
  resource_group_name   = data.azurerm_resource_group.win2019.name
  platform_fault_domain_count = 2
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                  = var.vm_name
  location              = data.azurerm_resource_group.win2019.location
  resource_group_name   = data.azurerm_resource_group.win2019.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = "Standard_D2s_v3"
  tags                  = var.azure_tags
  license_type          = "Windows_Server"
  admin_username        = azurerm_key_vault_secret.admin_name.value
  admin_password        = azurerm_key_vault_secret.admin_password.value
  provision_vm_agent    = true
  source_image_id       = data.azurerm_image.image.id
  availability_set_id   = azurerm_availability_set.as.id

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    name                   = "${var.vm_name}-OS-DISK"
    caching                = "ReadWrite"
    storage_account_type   = "StandardSSD_LRS"
    disk_encryption_set_id = azurerm_disk_encryption_set.des.id
  }

  depends_on = [azurerm_role_assignment.kv_crypto_des]
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "auto_shutdown" {
  virtual_machine_id    = azurerm_windows_virtual_machine.vm.id
  location              = data.azurerm_resource_group.win2019.location
  enabled               = true
  daily_recurrence_time = var.shutdown_time
  timezone              = var.shutdown_timezone

  notification_settings {
    enabled         = false
  }
}
