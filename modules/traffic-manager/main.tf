resource "azurerm_traffic_manager_profile" "tm" {
  name                = "aks-traffic-manager"
  resource_group_name = var.resource_group_name
  traffic_routing_method = "Priority"

  dns_config {
    relative_name = "aks-global"
    ttl           = 30
  }

  monitor_config {
    protocol = "HTTP"
    port     = 80
    path     = "/"
  }
}

resource "azurerm_traffic_manager_endpoint" "us" {
  name                = "aks-us-endpoint"
  profile_id          = azurerm_traffic_manager_profile.tm.id
  type                = "externalEndpoints"
  target              = var.us_endpoint
  priority            = 1
}

resource "azurerm_traffic_manager_endpoint" "ind" {
  name                = "aks-ind-endpoint"
  profile_id          = azurerm_traffic_manager_profile.tm.id
  type                = "externalEndpoints"
  target              = var.ind_endpoint
  priority            = 2
}

resource "azurerm_traffic_manager_endpoint" "aus" {
  name                = "aks-aus-endpoint"
  profile_id          = azurerm_traffic_manager_profile.tm.id
  type                = "externalEndpoints"
  target              = var.aus_endpoint
  priority            = 3
}
