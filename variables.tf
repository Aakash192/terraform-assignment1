variable "resource_group_name" {
  type = string
  description = "Name for the Azure Resource Group"
}

variable "location" {
  type = string
  description = "Region for the Azure resources"
}

# Uncomment and add variables for data disks, load balancer, or database modules if needed

# variable "subnet_id" {
#   type = string
#   description = "ID of the subnet for VM network interface"
# }

variable "admin_username" {
    type = string
}

variable "admin_password" {
    type = string
    sensitive = true  # Mark as sensitive
}

variable "windows_license_key" {
    type = string
}

