resource "azurerm_network_security_group" "nsg" {
    for_each = var.nsgs
    name = each.value.name
    location = each.value.location
    resource_group_name = each.value.resource_group_name
}


resource "azurerm_network_security_rule" "rule" {
    for_each = var.nsg_rules

    name = each.value.name
    priority = each.value.priority
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"

    source_port_range = "*"
    destination_port_range = each.value.destination_port_range
    source_address_prefix = "*"
    destination_address_prefix = "*"

    resource_group_name = each.value.resource_group_name
    network_security_group_name = each.value.network_security_group_name

    depends_on = [
        azurerm_network_security_group.nsg
    ]

}