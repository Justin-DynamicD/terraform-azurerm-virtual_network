######
# these variablles are mostly just maps with descriptions
# See the main.tf for defaults and validation for now
######

variable global_settings {
  type        = object ({
    location            = string
    name                = string
    resource_group_name = string
  })
  description = "collection of global variables common to evey resource"
}

variable network {
  type        = map(any)
  description = "collection of network setings for the virtual network"
  default     = null
}

variable subnets {
  type        = map(any)
  description = "collections of subnets organized by name"
  default     = null
}

variable ngw_settings {
  type        = map(any)
  description = "collection of NAT gateway setings"
  default     = null
}

variable ngw_subnet_azs {
  type        = map(any)
  description = "assign specific AZs to subnets using NAT gateway"
  default     = {}
}

variable subnet_service_endpoints {
  type        = map(list(string))
  description = "A map with key (string) `subnet name`, value (list(string)) to indicate enabled service endpoints on the subnet. Default value is []."
  default     = {}
}

variable "subnet_enforce_private_link_endpoint_network_policies" {
  description = "A map with key (string) `subnet name`, value (bool) `true` or `false` to indicate enable or disable network policies for the private link endpoint on the subnet. Default value is false."
  type        = map(bool)
  default     = {}
}

variable "subnet_enforce_private_link_service_network_policies" {
  description = "A map with key (string) `subnet name`, value (bool) `true` or `false` to indicate enable or disable network policies for the private link service on the subnet. Default value is false."
  type        = map(bool)
  default     = {}
}

variable tags {
  type        = map(any)
  description = "map of tags to apply to all resources"
  default     = null
}