# network_stack

This module standardizes the creation of networks and subnets with options to create managed nat gateways and AZ promises.  It was born from being frustrated with other modules that kept using count() statements instead of for_each() as I found it too brittle, and grew from there. The main goals/features here:

- creates a single virtual network
- creates multiple subnets
- can create a NAT Gateway per subnet with prefered AZ to create a zonal promise
- map service endpoints and policies as needed

This module bundles variables together into a map of strings fairly regularly, as it helps to organize things.  In most cases, the key value works as a join/unifier between desired subnets.  For example:

```yaml
module "vnet" {
  source = "../../resources/terraform/network_stack"
  global_settings  = {
    location            = "West US 2"
    resource_group_name = ""
  }
  network = {
    address_spaces     = ["10.10.0.0/16"]
  }
  subnets = {
    network1 = "10.10.0.0/20"
    network2 = "10.10.16.0/20"
    network3 = "10.10.32.0/20"
  }
  ngw_subnet_azs = {
    network1 = "1"
    network3 = "3"
  }
}
```

In this example, the network gateways in `ngw_subnet_azs` will be asigned to the subnet in `subnets` with the matching name.  As network2 does not have an associated key in `ngw_subnet_azs`, it will not get a NGW assigned.
