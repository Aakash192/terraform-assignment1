variable "location" {
  type = string
  description = "Region for the database instance"
}

variable "server_name" {
  type = string
  description = "Name for the database server"
}

variable "admin_username" {
  type = string
  description = "Administrator username for the database server"
}

variable "admin_password" {
  type = string
  description = "Administrator password for the database server"
}

resource "azurerm_mssql_server" "n01603990_db_server" {
  name                = var.server_name
  location            = var.location
  resource_group_name = azurerm_resource_group.n01603990_rg.name
  administrator_login  = var.admin_username
  administrator_login_password = var.admin_password

  sku {
    tier = "Basic"
    family = "B"
    size = "B1s"
  }

  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}

resource "azurerm_mssql_firewall_rule" "n01603990_db_firewall_rule" {
  name                = "n01603990_db_firewall_rule"
  resource_group_name = azurerm_resource_group.n01603990_rg.name
  server_name          = azurerm_mssql_server.n01603990_db_server.name

  start_ip_address  = "0.0.0.0"
  end_ip_address    = "0.0.0.0"
  start_port_range    = 5432
  end_port_range      = 5432

  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}

output "database_server_name" {
  value = azurerm_mssql_server.n01603990_db_server.name
}

