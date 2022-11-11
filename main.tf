######
# locals is a standard pattern I use to allow me to manipulate
# or create new variables in one spot for use. On simple modules
# I may just "pass-thru" vars to locals for consistency
######

locals {
  # these values are just mapped to local for consistency and have no transformation
  global_settings                               = var.global_settings
  network                                       = var.network
  ngw_settings                                  = var.ngw_settings
  ngw_subnet_azs                                = var.ngw_subnet_azs
  private_endpoint_network_policies_enabled     = var.private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled
  subnet_service_endpoints                      = var.subnet_service_endpoints
  subnets                                       = var.subnets
  tags                                          = var.tags
}
