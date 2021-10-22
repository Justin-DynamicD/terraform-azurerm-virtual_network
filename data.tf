
######
# Data lookups
######

data azurerm_resource_group "main" {
  name = local.global_settings.resource_group_name
}