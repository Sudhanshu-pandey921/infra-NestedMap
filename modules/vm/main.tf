resource "azurerm_network_interface" "nic" {
    for_each = var.nic

    name                = each.value.name
    location            = each.value.location
    resource_group_name = each.value.resource_group_name

    ip_configuration {
        name                          = each.value.ip_configuration.name
        subnet_id                     = each.value.ip_configuration.subnet_id
        private_ip_address_allocation = each.value.ip_configuration.private_ip_address_allocation
        public_ip_address_id          = each.value.ip_configuration.public_ip_address_id
    }
}

resource "azurerm_linux_virtual_machine" "vm" {
    for_each = var.vm

    name                = each.key == "vm1" ? var.vm_name_secret : "${var.vm_name_secret}-${each.key}"
    location            = each.value.location
    resource_group_name = each.value.resource_group_name
    size                = each.value.size
    admin_username      = each.value.admin_username
    admin_password      = var.vm_password

    disable_password_authentication = false

    network_interface_ids = [azurerm_network_interface.nic[each.value.nic_key].id]

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }
}