provider "azurerm" {
  features {}
  subscription_id            = var.sub_id
  skip_provider_registration = true
}

provider "tls" {}

data "azurerm_resource_group" "rg" {
  name = var.azure_resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = var.network_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}

resource "azurerm_public_ip" "publicip" {
  name                = "20200689-publicip"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic" {
  name                = "myNIC"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "myNICConfig"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.azure_vm_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  size                = "Standard_D2s_v3"
  admin_username      = var.user_admin
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.user_admin
    public_key = file("~/.ssh/id_rsa.pub")
  }
}

resource "tls_private_key" "main_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

