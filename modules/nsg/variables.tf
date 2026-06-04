variable "nsgs" {
    type = map(object({
        name = string
        location = string
        resource_group_name = string
    }))
}

variable "nsg_rules" {
    type = map(object({
        name                        = string
        priority                    = number
        destination_port_range      = string
        resource_group_name         = string
        network_security_group_name = string
    }))
}