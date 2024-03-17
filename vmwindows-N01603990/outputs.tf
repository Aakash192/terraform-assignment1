output "vm_hostname" {
  value = azurerm_virtual_machine.n01603990_vm.name
}

output "vm_domain_name" {
  value = format("%s.%s", azurerm_virtual_machine.n01603990_vm.name, azurerm_public_ip.n01603990_pip.domain_name)
}

output "vm_private_ip_address" {
  value = azurerm_virtual_machine.n01603990_vm.private_ip_address
}

output "vm_public_ip_address" {
  value = azurerm_public_ip.n01603990_pip.ip_address
}

