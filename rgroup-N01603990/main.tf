resource "azurerm_resource_group" "n01603990_rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}

output "resource_group_name" {
  value = azurerm_resource_group.n01603990_rg.name
}


