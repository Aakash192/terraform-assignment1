output "log_analytics_workspace_name" {
  value = azurerm_log_analytics_workspace.n01603990_log_analytics.name
}

output "recovery_services_vault_name" {
  value = azurerm_recovery_services_vault.n01603990_vault.name
}

output "storage_account_name" {
  value = azurerm_storage_account.n01603990_storage.name
}
