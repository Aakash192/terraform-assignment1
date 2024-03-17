variable "vm_ids" {
  type = list(string)
  description = "List of VM IDs to attach data disks to"
}

resource "azurerm_managed_disk" "n01603990_data_disk" {
  count = 4
  name   = format("n01603990_data_disk-%d", count.index)
  location = azurerm_resource_group.n01603990_rg.location
  resource_group_name = azurerm_resource_group.n01603990_rg.name
  sku {
    tier = "Standard_LRS"
  }
  storage_hb_tier = "StandardHDD"
  create_option = "Empty"
  disk_size_gb = 10
  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}

resource "azurerm_virtual_machine_data_disk" "n01603990_vm_data_disk" {
  count = length(var.vm_ids)

  name         = format("n01603990_vm_data_disk-%d", count.index)
  managed_disk_id = azurerm_managed_disk.n01603990_data_disk[count.index].id
  lun           = count.index
  caching       = "ReadWrite"
  create_option = "Attach"
  vm_id         = var.vm_ids[count.index]
}
