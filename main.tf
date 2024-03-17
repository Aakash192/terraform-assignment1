# Configure the Azure Provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Resource Group

resource "azurerm_resource_group" "n01603990_rg" {
  name     = var.resource_group_name
  location = var.location
}

# Call the Child Module for Network
module "network" {
  name   = "my-network"
  source = "./network-N01603990"

}

# Call the Child Module for VMs
module "vm_windows" {
  name   = "my-windows-vm"
  source = "./vmwindows-N01603990"
  subnet_id = module.network.virtual_network_subnet_id

  # Additional variables if needed (e.g., windows_license_key)
  windows_license_key = var.windows_license_key
}

# Call the Child Module for Data Disks (Optional)
module "data_disks" {
  name   = "my-data-disks"
  source = "./datadisk-N01603990"
  vm_ids = module.vm_windows.vm_private_ip_address

  depends_on = [module.vm_windows]
}

# Call the Child Module for Load Balancer (Optional)
module "load_balancer" {
  name   = "my-load-balancer"
  source = "./loadbalancer-N01603990"
  vm_ip_addresses = module.vm_windows.vm_public_ip_address

  depends_on = [module.vm_windows]
}

# Call the Child Module for Database (Optional)
module "database" {
  name   = "my-database-server"
  source = "./database-N01603990"
  location = var.location
  server_name = "n01603990-dbserver"
  admin_username = var.admin_username
  admin_password = var.admin_password
}

# Output Information from Child Modules

output "vm_windows_hostname" {
  value = module.vm_windows.vm_hostname
}

output "vm_windows_domain_name" {
  value = module.vm_windows.vm_domain_name
}

output "vm_windows_private_ip" {
  value = module.vm_windows.vm_private_ip_address
}

output "vm_windows_public_ip" {
  value = module.vm_windows.vm_public_ip_address
}

output "data_disk_ids" {
  value = module.data_disks.managed_disk_ids
}

output "load_balancer_name" {
  value = module.load_balancer.load_balancer_name
}

output "database_server_name" {
  value = module.database.database_server_name
}
