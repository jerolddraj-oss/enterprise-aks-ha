provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-aks-multiregion"
  location = "East US"
}

module "networking" {
  source              = "./modules/networking"
  location            = "East US"
  resource_group_name = azurerm_resource_group.rg.name
}

module "aks_us" {
  source              = "./modules/aks"
  cluster_name        = "aks-us"
  location            = "East US"
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = module.networking.spoke_subnet_id
}

module "aks_ind" {
  source              = "./modules/aks"
  cluster_name        = "aks-ind"
  location            = "Central India"
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = module.networking.spoke_subnet_id
}

module "aks_aus" {
  source              = "./modules/aks"
  cluster_name        = "aks-aus"
  location            = "Australia East"
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = module.networking.spoke_subnet_id
}

module "monitoring_us" {
  source              = "./modules/monitoring"
  location            = "East US"
  resource_group_name = azurerm_resource_group.rg.name
  aks_id              = module.aks_us.id
}

module "monitoring_ind" {
  source              = "./modules/monitoring"
  location            = "Central India"
  resource_group_name = azurerm_resource_group.rg.name
  aks_id              = module.aks_ind.id
}

module "monitoring_aus" {
  source              = "./modules/monitoring"
  location            = "Australia East"
  resource_group_name = azurerm_resource_group.rg.name
  aks_id              = module.aks_aus.id
}
