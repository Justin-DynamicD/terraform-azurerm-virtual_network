######
# locals allow me to organize and merge values 
# and create flexible objects with optional
# attributes via merge() for applying settings.
# This may be redone when terraform adds a 
# native feature (one is in preview)
######

locals {
  defaults = {
    network = {
      address_spaces     = []
      dns_servers        = []
    }
    ngw_settings = {
      public_ip_allocation_method = "Static"
      public_ip_sku               = "Standard"
      ngw_sku                     = "Standard"
      idle_timeout_in_minutes     = "10"
    }
  }

  # merge the default vlaues with varaibles here for a dynamic list of settings:
  network           = merge(local.defaults.network, var.network)
  ngw_settings      = merge(local.defaults.ngw_settings, var.ngw_settings)


  # these values are just mapped to local for consistency and have no transformation
  global_settings   = var.global_settings
  ngw_subnet_azs    = var.ngw_subnet_azs
  service_endpoints = var.service_endpoints
  subnets           = var.subnets
  tags              = var.tags
}
