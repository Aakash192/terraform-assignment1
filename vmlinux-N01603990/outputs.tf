output "log_analytics_workspace_name" {
  value = azurerm_log_analytics_workspace.N01603990_log_analytics.name
}

output "recovery_services_vault_name" {
  value = azurerm_recovery_services_vault.N01603990_vault.name
}

output "storage_account_name" {
  value = azurerm_storage_account.N01603990_storage.name
}
