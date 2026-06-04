output "nic_ids" {
  value = { for k, nic in azurerm_network_interface.nic : k => nic.id }
}

output "vm_ids" {
  value = { for k, virtual_machine in azurerm_linux_virtual_machine.vm : k => virtual_machine.id }
}