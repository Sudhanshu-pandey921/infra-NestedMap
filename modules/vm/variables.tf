variable "nic" {
    type = map(object({
        name                = string
        location            = string
        resource_group_name = string
        ip_configuration = object({
            name                          = string
            subnet_id                     = string
            private_ip_address_allocation = string
            public_ip_address_id          = optional(string)
        })
    }))
}

variable "vm" {
    type = map(object({
        location = string
        resource_group_name = string
        size = string
        admin_username = string
        nic_key = string
    }))
    description = "VM configuration (name and password provided separately from Key Vault)"
}

variable "vm_name_secret" {
    type        = string
    description = "VM name from Key Vault"
    sensitive   = true
}

variable "vm_password" {
    type        = string
    description = "VM admin password from Key Vault"
    sensitive   = true
}