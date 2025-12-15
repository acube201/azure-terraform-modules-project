output "vm_public_ip" {
  description = "Public IP address of the VM"
  # module.network exposes the public IP resource id as `public_ip_id`.
  # If you need the actual IP address, add an output in `modules/network` that returns
  # `azurerm_public_ip.vm_pip.ip_address`.
  value = module.network.public_ip_address
}

output "vm_admin_username" {
  description = "Admin username for the VM"
  value       = module.vm.vm_admin_username
}

output "vm_name" {
  description = "Name of the VM"
  value       = module.vm.vm_name
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.network.resource_group_name
}
