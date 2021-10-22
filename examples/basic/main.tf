provider azurerm {
  features{}
}

resource azurerm_resource_group "example" {
  name = "example"
  location = "westus2"
}

module "myvnet" {
  source = "github.com/Justin-DynamicD/terraform-azurerm-virtual_network.git"
  global_settings  = {
    name                = "example_vnet"
    location            = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name
  }
  network = {
    address_spaces     = ["10.10.0.0/16"]
  }
  subnets = {
    default = "10.10.100.0/24"
  }
  tags = {
    Project   = "networking"
    Terraform = true
  }
}