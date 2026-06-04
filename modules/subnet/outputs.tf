output "ids" {
  value = { for k, subnet in azurerm_subnet.subnet : k => subnet.id }
}

output "subnet_id" {
  value = { for k, subnet in azurerm_subnet.subnet : k => subnet.id }
}