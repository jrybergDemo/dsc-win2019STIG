data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.vnet_rg_name
}

data "azurerm_subnet" "vm" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}

resource "azurerm_public_ip" "public_ip" {
  name                          = var.pip_name
  resource_group_name           = data.azurerm_resource_group.win2019.name
  location                      = data.azurerm_resource_group.win2019.location
  allocation_method             = "Static"
  domain_name_label             = lower(var.vm_name)
}

resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = data.azurerm_resource_group.win2019.location
  resource_group_name = data.azurerm_resource_group.win2019.name

  ip_configuration {
    name                          = "${var.nic_name}-CONFIG"
    subnet_id                     = data.azurerm_subnet.vm.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_application_security_group" "asg" {
  name                = var.asg_name
  location            = data.azurerm_resource_group.win2019.location
  resource_group_name = data.azurerm_resource_group.win2019.name
}

resource "azurerm_network_interface_application_security_group_association" "nic2asg" {
  network_interface_id          = azurerm_network_interface.nic.id
  application_security_group_id = azurerm_application_security_group.asg.id
}
