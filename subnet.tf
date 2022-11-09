resource azurerm_virtual_network "main" {
  name                = local.global_settings.name
  resource_group_name = local.global_settings.resource_group_name
  location            = local.global_settings.location
  address_space       = local.network.address_spaces
  dns_servers         = local.network.dns_servers
  tags                = local.tags
}

resource "azurerm_subnet" "subnet" {
  for_each                                       = local.subnets
  name                                           = each.key
  resource_group_name                            = local.global_settings.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.main.name
  address_prefixes                               = [each.value]
  service_endpoints                              = lookup(local.subnet_service_endpoints, each.key, [])
  private_endpoint_network_policies_enabled      = lookup(local.private_endpoint_network_policies_enabled, each.key, false)
  private_link_service_network_policies_enabled  = lookup(local.private_link_service_network_policies_enabled, each.key, false)
}

# resource "azurerm_subnet_route_table_association" "vnet" {
#   for_each       = var.route_tables_ids
#   route_table_id = each.value
#   subnet_id      = local.azurerm_subnets[each.key]
# }