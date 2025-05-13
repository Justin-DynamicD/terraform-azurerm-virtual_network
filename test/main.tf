provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "test" {
  name     = "test-virtual-network"
  location = "westus2"
}

module "basic" {
  source = "../"
  global_settings = {
    name                = "basic_vnet"
    location            = azurerm_resource_group.test.location
    resource_group_name = azurerm_resource_group.test.name
  }
  network = {
    address_spaces = ["10.10.0.0/16"]
  }
  subnets = {
    default = "10.10.100.0/24"
  }
  tags = {
    Test      = "basic"
    Terraform = true
  }
}

module "multi_az" {
  source = "../"
  global_settings = {
    name                = "multi_az_vnet"
    location            = azurerm_resource_group.test.location
    resource_group_name = azurerm_resource_group.test.name
  }
  network = {
    address_spaces = ["10.10.0.0/16"]
  }
  subnets = {
    agw      = "10.10.100.0/24"
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
    Test      = "multi-az"
    Terraform = true
  }
}

module "aks" {
  source = "../"
  global_settings = {
    name                = "aks_vnet"
    location            = azurerm_resource_group.test.location
    resource_group_name = azurerm_resource_group.test.name
  }
  network = {
    address_spaces = ["10.10.0.0/16"]
  }
  subnets = {
    agw          = "10.10.100.0/24"
    internal_lb  = "10.10.110.0/24"
    aks          = "10.10.10.0/24"
    private_link = "10.10.5.0/24"
  }
  private_link_service_network_policies_enabled = {
    private_link = true
  }
  subnet_service_endpoints = {
    private_link = ["Microsoft.KeyVault", "Microsoft.ContainerRegistry"]
  }
  tags = {
    Test      = "aks"
    Terraform = true
  }
}