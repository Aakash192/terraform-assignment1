resource "azurerm_virtual_machine" "n01603990_vm" {
  count               = 1
  name                = "n01603990_vm"
  location            = azurerm_resource_group.n01603990_rg.location
  resource_group_name = azurerm_resource_group.n01603990_rg.name

  availability_set {
    reference {
      id = azurerm_availability_set.n01603990_as.id
    }
  }

  vm_size_id = "B1s"

  network_interface_ids = [azurerm_network_interface.n01603990_nic.id]

  storage_os_disk {
    name              = "n01603990_osdisk"
    create_option     = "FromImage"
    caching           = "ReadWrite"
    managed_disk_type = "Standard_LRS"
    image_uri         = "Windows Server 2016 Datacenter:windows-server-2016-datacenter-with-desktop:latest"
  }

  storage_data_disks = []

  os_profile {
    computer_name  = "n01603990_vm"
    windows_license_key = var.windows_license_key
  }

  diagnostics_profile {
    boot_diagnostics {
      enabled = true
      storage_uri = azurerm_storage_account.N01603990_storage.primary_endpoints.blob
    }
  }

  extension {
    publisher = "Microsoft.Antimalware"
    name      = "Antimalware"
    version   = "1.1"
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
  location            = azurerm_resource_group.n01603990_rg.location
  resource_group_name = azurerm_resource_group.n01603990_rg.name

  managed_disk_type = "Standard_LRS"

  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}

resource "azurerm_network_interface" "n01603990_nic" {
  name                = "n01603990_nic"
  location            = azurerm_resource_group.n01603990_rg.location
  resource_group_name = azurerm_resource_group.n01603990_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  network_security_group_id = azurerm_network_security_group.n01603990_nsg.id

  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}

resource "azurerm_public_ip" "n01603990_pip" {
  name                = "n01603990_pip"
    location            = azurerm_resource_group.n01603990_rg.location
  resource_group_name = azurerm_resource_group.n01603990_rg.name

  allocation_method = "Dynamic"

  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}

resource "azurerm_network_interface_ip_configuration" "n01603990_nic_ip_config" {
  name                = "internal"
  network_interface_id = azurerm_network_interface.n01603990_nic.id

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  public_ip_address_id = azurerm_public_ip.n01603990_pip.id

  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}
