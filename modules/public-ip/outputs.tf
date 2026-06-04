output "ids" {
  value = { for k, pip in azurerm_public_ip.pip : k => pip.id }
}

output "public_ip_id" {
  value = { for k, pip in azurerm_public_ip.pip : k => pip.id }
}