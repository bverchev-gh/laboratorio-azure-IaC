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

# 1. GRUPO DE RECURSOS DO TUTORIAL HASHICORP (Usando Variável)
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "eastus"

  tags = {
    Environment = "Terraform Getting Started"
    Team        = "DevOps"
  }
}  

# 2. REDE VIRTUAL (VNet) - Adicionada agora conforme o tutorial
resource "azurerm_virtual_network" "vnet" {
  name                = "myTFVnet"
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  resource_group_name = azurerm_resource_group.rg.name
}

