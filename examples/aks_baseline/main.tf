provider azurerm {
  features{}
}

resource azurerm_resource_group "example" {
  name = "example"
  location = "westus2"
}

module "myvnet" {
  source = "Justin-DynamicD/virtual_network/azurerm"
  global_settings  = {
    name                = "aks_vnet"
    location            = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name
  }
  network = {
    address_spaces     = ["10.10.0.0/16"]
  }
  subnets = {
    agw          = "10.10.100.0/24"
    aks_ingress  = "10.10.110.0/24"
    aks_nodes    = "10.10.50.0/24"
    private_link = "10.10.10.0/24"
  }
  private_link_service_network_policies_enabled = {
    private_link = true
  }
  subnet_service_endpoints = {
    private_link = ["Microsoft.KeyVault","Microsoft.ContainerRegistry"]
  }
  tags = {
    Level   = "2"
    Terraform = true
  }
}