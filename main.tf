######
# locals allow me to organize and merge values 
# and create flexible objects with optional
# attributes via merge() for applying settings.
#This may be redone when terraform adds a 
# native feature (one is in preview)
######

locals {
  defaults = {
    global_settings   = {
      location            = ""
      name                = ""
      resource_group_name = ""
    }
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
    subnets           = {}
    ngw_subnet_azs    = {}
    service_endpoints = {}
    tags = {
      Terraform = true
    }
  }

  # merge the default vlaues with varaibles here:
  global_settings   = merge(local.defaults.global_settings, var.global_settings)
  network           = merge(local.defaults.network, var.network)
  ngw_settings      = merge(local.defaults.ngw_settings, var.ngw_settings)
  ngw_subnet_azs    = merge(local.defaults.ngw_subnet_azs, var.ngw_subnet_azs)
  service_endpoints = merge(local.defaults.service_endpoints, var.service_endpoints)
  subnets           = merge(local.defaults.subnets, var.subnets)
  tags              = merge(local.defaults.tags, var.tags)
}
