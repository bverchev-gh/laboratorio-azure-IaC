# ==============================================================================
# CONFIGURAÇÃO DO TERRAFORM E PROVIDERS NATIVOS
# ==============================================================================
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# ==============================================================================
# 1. GRUPO DE RECURSOS (Resource Group - Puxando do arquivo de variáveis)
# ==============================================================================
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# ==============================================================================
# 2. INFRAESTRUTURA DE REDE (VNet e Sub-rede Corporativa)
# ==============================================================================
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-infra-cloud-v2"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "snet-producao-v2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# ==============================================================================
# 3. FIREWALL DE REDE (Network Security Group - Regras de Hardening)
# ==============================================================================
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-windows-seguro"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Permitir-RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# ==============================================================================
# 4. INTERFACE DE REDE (Placa de Rede Virtual do Servidor)
# ==============================================================================
resource "azurerm_network_interface" "nic" {
  name                = "nic-srvwin01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Associa o Firewall (NSG) à Placa de Rede (NIC)
resource "azurerm_network_interface_security_group_association" "associacao" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# ==============================================================================
# 5. MÁQUINA VIRTUAL (Windows Server Datacenter 2022)
# ==============================================================================
resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm_size
  admin_username      = "admincloud"
  admin_password      = "SenhaF0rte123!"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}
