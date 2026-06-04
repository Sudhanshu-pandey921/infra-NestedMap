variable "rg" {
    type = map(object({
        name     = string
        location = string
    }))
    default = {}
    description = "Resource Groups configuration"
}

variable "vnet" {
    type = map(object({
        name = string
        address_space = list(string)
        location = string
        resource_group_name = string
    }))
    default = {}
    description = "Virtual Networks configuration"
}

variable "subnets" {
    type = map(object({
        name                 = string
        resource_group_name  = string
        virtual_network_name = string
        address_prefixes     = list(string)
    }))
    default = {}
    description = "Subnets configuration"
}

variable "nsgs" {
    type = map(object({
        name = string
        location = string
        resource_group_name = string
    }))
    default = {}
    description = "Network Security Groups configuration"
}

variable "nsg_rules" {
    type = map(object({
        name                        = string
        priority                    = number
        destination_port_range      = string
        resource_group_name         = string
        network_security_group_name = string
    }))
    default = {}
    description = "NSG Rules configuration"
}

variable "nsg_associations" {
    type = map(object({
        subnet_key = string
        nsg_key    = string
    }))
    default = {}
    description = "Map of NSG associations with subnet and nsg keys"
}

variable "public_ip" {
    type = map(object({
        name                = string
        location            = string
        resource_group_name = string
        allocation_method   = string
    }))
    default = {}
    description = "Public IPs configuration"
}

variable "nic" {
    type = map(object({
        name                = string
        location            = string
        resource_group_name = string
        ip_config_name      = string
        subnet_key          = string
        public_ip_key       = optional(string)
    }))
    default = {}
    description = "Network Interface configurations"
}

variable "vm" {
    type = map(object({
        location = string
        resource_group_name = string
        size = string
        admin_username = string
        nic_key = string
    }))
    default = {}
    description = "VM configuration (name and password sourced from Key Vault)"
}

