resource "azurerm_virtual_machine" "n01603990_vm" {
  for_each = toset(range(3))

  name                  = format("n01603990_vm-%d", each.key)
  location              = azurerm_resource_group.humberid_rg.location
  resource_group_name   = azurerm_resource_group.humberid_rg.name

  availability_set {
    reference {
      id = azurerm_availability_set.n01603990_as.id
    }
  }

  vm_size_id = "B1ms"

  network_interface_ids = [azurerm_network_interface.n01603990_nic[each.key].id]

  storage_os_disk {
    name              = format("n01603990_osdisk-%d", each.key)
    create_option     = "FromImage"
    caching           = "ReadWrite"
    managed_disk_type = "Standard_LRS"
    image_uri         = "CentOS:centos-linux:8.2:latest"
  }

  storage_data_disks = []

  os_profile {
    computer_name  = format("n01603990_vm-%d", each.key)
    linux_fx       = "CentOS"
  }

  diagnostics_profile {
    boot_diagnostics {
      enabled = true
      storage_uri = azurerm_storage_account.humberid_storage.primary_endpoints.blob
    }
  }

  extension {
    publisher = "Microsoft.Azure.NetworkWatcher"
    name      = "NetworkWatcherAgentLinux"
    version   = "1.0"
  }

  extension {
    publisher = "Microsoft.Azure.Monitor"
    name      = "AzureMonitorLinuxAgent"
    version   = "1.0"
  }

  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}

resource "azurerm_availability_set" "n01603990_as" {
  name                = "n01603990_as"
  location            = azurerm_resource_group.humberid_rg.location
  resource_group_name = azurerm_resource_group.humberid_rg.name

  managed_disk_type = "Standard_LRS"

  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}

resource "azurerm_network_interface" "n01603990_nic" {
  count               = length(var.subnet_ids)
  name                = format("n01603990_nic-%d", count.index)
  location            = azurerm_resource_group.humberid_rg.location
  resource_group_name = azurerm_resource_group.humberid_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_ids[count.index]
    private_ip_address_allocation = "Dynamic"
  }

  network_security_group_id = azurerm_network_security_group.humberid_nsg.id

  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}

resource "azurerm_public_ip" "n01603990_pip" {
    count               = length(var.subnet_ids)
  name                = format("n01603990_pip-%d", count.index)
  location            = azurerm_resource_group.humberid_rg.location
  resource_group_name = azurerm_resource_group.humberid_rg.name

  allocation_method = "Dynamic"

  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}

resource "azurerm_network_interface_ip_configuration" "n01603990_nic_ip_config" {
  count               = length(var.subnet_ids)
  name                = format("n01603990_nic_ip_config-%d", count.index)
  network_interface_id = azurerm_network_interface.n01603990_nic[count.index].id
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_ids[count.index]
    private_ip_address_allocation = "Dynamic"
  }

  public_ip_address_id = azurerm_public_ip.n01603990_pip[count.index].id

  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}

# Remote exec provisioner to get VM hostnames (requires null provider)
provisioner "null" {
  on_destroy = true
  connection {
    host = azurerm_virtual_machine.n01603990_vm[0].ip_address
  }
  # Script to get VM hostnames (replace with actual command)
  command = "hostnamectl; sleep 5"
  environment {
    VM_NAME_0 = azurerm_virtual_machine.n01603990_vm[0].name
    VM_NAME_1 = azurerm_virtual_machine.n01603990_vm[1].name
    VM_NAME_2 = azurerm_virtual_machine.n01603990_vm[2].name
  }
}

output "vm_hostnames" {
  value = split(trimright(null_provisioner.null.stdout, "\n"), "\n")
}

output "vm_domain_names" {
  value = [
    for vm in azurerm_virtual_machine.n01603990_vm : format("%s.%s", vm.name, azurerm_public_ip.n01603990_pip[each.key].domain_name)
  ]
}

output "vm_private_ip_addresses" {
  value = [for vm in azurerm_virtual_machine.n01603990_vm : vm.private_ip_address]
}

output "vm_public_ip_addresses" {
  value = [for vm in azurerm_virtual_machine.n01603990_vm : azurerm_public_ip.n01603990_pip[each.key].ip_address]
}


