######
# these variablles are mostly just maps with descriptions
# See the main.tf for defaults and validation for now
######

variable global_settings {
  type        = map(any)
  description = "collection of global variables common to evey resource"
  default     = null
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
  default     = null
}

variable service_endpoints {
  type        = map(any)
  description = "collection of service endpoints"
  default     = null
}

variable tags {
  type        = map(any)
  description = "map of tags to apply to all resources"
  default     = null
}