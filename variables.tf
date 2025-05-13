######
# With the new optional attributes feature in 1.3 this
# is once again a complete var collection with defaults
######

variable "global_settings" {
  type = object({
    location            = string
    name                = string
    resource_group_name = string
  })
  description = "collection of global variables common to evey resource"
}

variable "network" {
  type = object({
    address_spaces = optional(list(string), [])
    dns_servers    = optional(list(string), [])
  })
  default     = {}
  description = "collection of network setings for the virtual network"
}

variable "subnets" {
  type        = map(any)
  description = "collections of subnets organized by name"
  default     = null
}

variable "ngw_settings" {
  type = object({
    public_ip_allocation_method = optional(string, "Static")
    public_ip_sku               = optional(string, "Standard")
    ngw_sku                     = optional(string, "Standard")
    idle_timeout_in_minutes     = optional(number, 10)
  })
  default     = {}
  description = "collection of NAT gateway setings"
}

variable "ngw_subnet_azs" {
  type        = map(any)
  description = "assign specific AZs to subnets using NAT gateway"
  default     = {}
}

variable "subnet_service_endpoints" {
  type        = map(list(string))
  description = "A map with key (string) `subnet name`, value (list(string)) to indicate enabled service endpoints on the subnet. Default value is []."
  default     = {}
}

variable "private_endpoint_network_policies" {
  description = "A map with key (string) `subnet name`, value (string) [`Enabled`,`Disabled`,`NetworkSecurityGroupEnabled`,`RouteTableEnabled`] to indicate enable or disable network policies for the private link endpoint on the subnet. Default value is `Disabled`."
  type        = map(string)
  default     = {}

  validation {
    condition     = alltrue([for v in var.private_endpoint_network_policies : v == "Enabled" || v == "Disabled" || v == "NetworkSecurityGroupEnabled" || v == "RouteTableEnabled"])
    error_message = "Each subnet policy must be one of [`Enabled`, `Disabled`, `NetworkSecurityGroupEnabled`, `RouteTableEnabled`]."
  }
}

variable "private_link_service_network_policies_enabled" {
  description = "A map with key (string) `subnet name`, value (bool) `true` or `false` to indicate enable or disable network policies for the private link service on the subnet. Default value is false."
  type        = map(bool)
  default     = {}
}

variable "tags" {
  type        = map(any)
  description = "map of tags to apply to all resources"
  default     = null
}
