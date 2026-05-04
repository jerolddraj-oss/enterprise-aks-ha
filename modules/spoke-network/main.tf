resource "azurerm_resource_group" "spoke_rg" {
  name     = "spoke-${replace(var.location, " ", "")}-rg"
  location = var.location
}

resource "azurerm_virtual_network" "spoke_vnet" {
  name                = "spoke-${replace(var.location, " ", "")}-vnet"
  location            = azurerm_resource_group.spoke_rg.location
  resource_group_name = azurerm_resource_group.spoke_rg.name
  address_space       = [var.vnet_cidr]
}
