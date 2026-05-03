provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-aks-multiregion"
  location = "East US"
}

module "aks_us" {
  source              = "./modules/aks"
  cluster_name        = "aks-us"
  location            = "East US"
  resource_group_name = azurerm_resource_group.rg.name
}

module "aks_ind" {
  source              = "./modules/aks"
  cluster_name        = "aks-ind"
  location            = "Central India"
  resource_group_name = azurerm_resource_group.rg.name
}

module "aks_aus" {
  source              = "./modules/aks"
  cluster_name        = "aks-aus"
  location            = "Australia East"
  resource_group_name = azurerm_resource_group.rg.name
}
