output "vnet_address_space" {
  value = azurerm_virtual_network.main.address_space
}

output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "vnet_location" {
  value = azurerm_virtual_network.main.location
}

output "vnet_name" {
  value = azurerm_virtual_network.main.name
}

output "vnet_subnets" {
  value =  azurerm_subnet.subnet
}
