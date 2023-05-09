# Crear un grupo de recursos
terraform {
    required_providers {
        azurerm = {
        source  = "hashicorp/azurerm"
        version = "3.0.0"
        
        }
    }
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "rg" {
    name     = "rg-bcirg3citperuacr002"
    location = "eastus"
}

# Crear una red virtual
resource "azurerm_virtual_network" "vnet" {
    name                = "vnet-bcirg3citperuacr002"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
}

# Crear una subred
resource "azurerm_subnet" "subnet" {
    name                 = "subnet-bcirg3citperuacr002"
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes       = ["10.0.0.0/16"]
}

# Crear una interfaz de red
resource "azurerm_network_interface" "nic" {
    name                = "nic-bcirg3citperuacr002"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.subnet.id
        private_ip_address_allocation = "Dynamic"
    }
}