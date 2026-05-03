output "hub_vnet_id" {
  value = azurerm_virtual_network.hub.id
}

output "spoke_vnet_id" {
  value = azurerm_virtual_network.spoke.id
}

output "spoke_subnet_id" {
  value = azurerm_subnet.spoke_subnet.id
}
