output "resource_group_name" {
  value = { for k, rg in azurerm_resource_group.rg : k => rg.name }
}

output "resource_group_id" {
  value = { for k, rg in azurerm_resource_group.rg : k => rg.id }
}
