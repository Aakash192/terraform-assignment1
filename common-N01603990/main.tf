resource "azurerm_log_analytics_workspace" "n01603990_log_analytics" {
  name                = var.log_analytics_workspace_name
  location            = azurerm_resource_group.n01603990_rg.location
  resource_group_name = azurerm_resource_group.n01603990_rg.name

  sku {
    name = "Free"
  }

  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}

resource "azurerm_recovery_services_vault" "n01603990_vault" {
  name                = var.recovery_services_vault_name
  location            = azurerm_resource_group.n01603990_rg.location
  resource_group_name = azurerm_resource_group.n01603990_rg.name

  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}

resource "azurerm_storage_account" "n01603990_storage" {
  name                = var.storage_account_name
  location            = azurerm_resource_group.n01603990_rg.location
  resource_group_name = azurerm_resource_group.n01603990_rg.name
  account_tier         = "Standard"
  account_replication_type = "LRS"

  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}

output "log_analytics_workspace_name" {
  value = azurerm_log_analytics_workspace.n01603990_log_analytics.name
}

output "recovery_services_vault_name" {
  value = azurerm_recovery_services_vault.n01603990_vault.name
}

output "storage_account_name" {
  value = azurerm_storage_account.n01603990_storage.name
}
