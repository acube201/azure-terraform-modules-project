output "vm_name" {
  description = "Deployed VM name"
  value       = azurerm_windows_virtual_machine.vm.name
}

output "vm_admin_username" {
  description = "Admin username of the VM"
  value       = azurerm_windows_virtual_machine.vm.admin_username
}
