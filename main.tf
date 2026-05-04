module "hub" {
  source    = "./modules/hub-network"
  location  = "East US"
  vnet_cidr = "10.0.0.0/16"
}

module "spokes" {
  for_each = toset(var.regions)

  source    = "./modules/spoke-network"
  location  = each.value
  vnet_cidr = lookup({
    "East US"        = "10.1.0.0/16",
    "Australia East" = "10.2.0.0/16",
    "Central India"  = "10.3.0.0/16"
  }, each.value)
}
