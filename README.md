# network_stack

This module standardizes the creation of networks and subnets with options to create managed nat gateways and AZ promises.  It was born from being frustrated with other modules that kept using count() statements instead of for_each() as I found it too brittle, and grew from there. The main goals/features here:

- creates a single virtual network
- creates multiple subnets
- can create a NAT Gateway per subnet with prefered AZ to create a zonal promise
- map service endpoints and policies as needed

This module bundles variables together into a map of strings fairly regularly, as it helps to organize things.  In most cases, the key value works as a join/unifier between desired subnets.  For example:

```yaml
module "vnet" {
  source  = "Justin-DynamicD/virtual_network/azurerm"
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

## Variable Blocks

### global_settings

```yaml
global_settings = {
  location            = ""
  name                = ""
  resource_group_name = ""
}
```

| name | type | required | default | description |
| --- | --- | --- | --- | --- |
| location | string | yes | - | sets the region for all resources created |
| name | string | yes | - | used for both the name of the virtual network and supporting resources where needed |
| resource_group_name | string | yes | - | name of the resource group in which to place all created resources |

### network

```yaml
network = {
  address_spaces = []
  dns_servers    = []
}
```

| name | type | required | default | description |
| --- | --- | --- | --- | --- |
| address_spaces | list(string) | yes | - | list of CIDR blocks for the vnet ex: "10.0.0.0/8" |
| dns_servers | list(string) | no | [] | override Azure DNS servers with a defined set |

### ngw_settings

```yaml
ngw_settings = {
  public_ip_allocation_method = "Static"
  public_ip_sku               = "Standard"
  ngw_sku                     = "Standard"
  idle_timeout_in_minutes     = "10"
}
```

| name | type | required | default | description |
| --- | --- | --- | --- | --- |
| public_ip_allocation_method | string | no | Static | public IP address allocation method |
| public_ip_sku | string | no | Standard | SKU/Tier for the Public IP |
| ngw_sku | string | no | Standard | SKU/Tier for the NAT Gateway |
| idle_timeout_in_minutes | string | no | 10 | session timeout for NAT Gateway |

### subnets

```yaml
subnets = {
  subnet1 = "192.168.1.0/24"
}
```

This is a key/value list of subnet names and IP ranges. All IP ranges must fit within the superscope defined in `network.address_spaces`. Excluding this map will will create a network with no subnets defined.

### ngw_subnet_azs

```yaml
ngw_subnet_azs = {
  subnet1 = null
}
```

This is a key/value list of subnet names that will have a NAT gateway created and associated.  The key is the name of the matching subnet, the value can be defined as `null` to creeate a regional NGW, or a `int` can be defined to assign the NGW to a specific availability zone and create a zonal promise.  This `int` must be a valid availability zone in a supported region.

### tags

```yaml
tags = {
  Terraform = "true"
}
```

Map of tags to apply to every resource that is created.
