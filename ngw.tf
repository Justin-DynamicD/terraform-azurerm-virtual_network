resource "azurerm_public_ip" "main" {
  for_each            = local.ngw_subnet_azs
  name                = "${local.global_settings.name}-${each.key}"
  location            = local.global_settings.location
  resource_group_name = local.global_settings.resource_group_name
  allocation_method   = local.ngw_settings.public_ip_allocation_method
  sku                 = local.ngw_settings.public_ip_sku
  availability_zone   = each.value != null ? each.value : null
  tags                = local.tags
}

resource "azurerm_nat_gateway" "main" {
  for_each                                  = local.ngw_subnet_azs
  name                                      = "${local.global_settings.name}-${each.key}"
  location                                  = local.global_settings.location
  resource_group_name                       = local.global_settings.resource_group_name
  sku_name                                  = local.ngw_settings.ngw_sku
  idle_timeout_in_minutes                   = local.ngw_settings.idle_timeout_in_minutes
  zones                                     = each.value != null ? [each.value] : null
  tags                                      = local.tags
}

# associate the IP and subnet

resource "azurerm_nat_gateway_public_ip_association" "main" {
  for_each             = local.ngw_subnet_azs
  nat_gateway_id       = azurerm_nat_gateway.main[each.key].id
  public_ip_address_id = azurerm_public_ip.main[each.key].id
}

resource "azurerm_subnet_nat_gateway_association" "main" {
  for_each       = local.ngw_subnet_azs
  subnet_id      = azurerm_subnet.subnet[each.key].id
  nat_gateway_id = azurerm_nat_gateway.main[each.key].id
}