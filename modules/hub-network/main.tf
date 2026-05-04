resource "azurerm_resource_group" "hub_rg" {
  name     = "hub-rg"
  location = var.location
}

resource "azurerm_virtual_network" "hub_vnet" {
  name                = "hub-vnet"
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name
  address_space       = [var.vnet_cidr]
}
