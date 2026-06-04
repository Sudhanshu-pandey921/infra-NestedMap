output "vnet_name" {
  value = { for k, vnet in azurerm_virtual_network.vnet : k => vnet.name }
}

output "vnet_id" {
  value = { for k, vnet in azurerm_virtual_network.vnet : k => vnet.id }
}
