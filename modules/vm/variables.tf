variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vm_name" {
  description = "Virtual machine name"
  type        = string
}

variable "nic_name" {
  description = "Network interface name"
  type        = string
}

variable "vm_size" {
  description = "VM size SKU"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}

variable "subnet_id" {
  description = "Subnet ID to attach the NIC"
  type        = string
}

variable "public_ip_id" {
  description = "Public IP ID to attach to NIC"
  type        = string
}
variable "environment" {
  type        = string
  description = "Deployment environment (dev or prod)"
}  


