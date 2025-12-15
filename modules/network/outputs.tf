output "subnet_id" {
  description = "ID of the subnet where the VM will live"
  value       = azurerm_subnet.subnet.id
}

output "public_ip_id" {
  description = "ID of the public IP for the VM"
  value       = azurerm_public_ip.vm_pip.id
}

output "public_ip_address" {
  description = "The actual public IP address assigned to the VM"
  value       = azurerm_public_ip.vm_pip.ip_address
}

output "resource_group_name" {
  description = "Resource group name passed into the network module"
  value       = var.resource_group_name
}

