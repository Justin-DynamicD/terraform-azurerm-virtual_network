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
    agw = "10.10.100.0/24"
    private1 = "10.10.0.0/20"
    private2 = "10.10.16.0/20"
    private3 = "10.10.32.0/20"
  }
  ngw_subnet_azs = {
    private1 = "1"
    private2 = "2"
    private3 = "3"
  }
  tags = {
    Project   = "networking"
    Terraform = true
  }
}