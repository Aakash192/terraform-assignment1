variable "vm_ip_addresses" {
  type = list(string)
  description = "List of public IP addresses of the Linux VMs"
}

resource "azurerm_lb" "n01603990_lb" {
  name                = "n01603990_lb"
  location            = azurerm_resource_group.n01603990_rg.location
  resource_group_name = azurerm_resource_group.n01603990_rg.name
  sku {
    name = "Basic"
  }

  frontend_ip_configuration {
    name                 = "n01603990_lb_frontend"
    public_ip_address_id = azurerm_public_ip.n01603990_lb_pip.id
  }

  backend_address_pool {
    name = "n01603990_lb_backendpool"
  }

  load_balancing_rule {
    name              = "n01603990_lb_rule"
    frontend_ip_configuration_name = azurerm_lb.n01603990_lb.frontend_ip_configuration[0].name
    backend_address_pool_name      = azurerm_lb.n01603990_lb.backend_address_pool[0].name
    protocol                          = "Tcp"
    frontend_port                     = 80
    backend_port                      = 80
  }

  inbound_nat_rule {
    name                = "n01603990_lb_in_rule"
    rule_name             = azurerm_lb.n01603990_lb.load_balancing_rule[0].name
    frontend_port        = 80
    frontend_ip_configuration_name = azurerm_lb.n01603990_lb.frontend_ip_configuration[0].name
  }

  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}

resource "azurerm_public_ip" "n01603990_lb_pip" {
  name                = "n01603990_lb_pip"
  location            = azurerm_resource_group.n01603990_rg.location
  resource_group_name = azurerm_resource_group.n01603990_rg.name
  allocation_method   = "Dynamic"

  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}

resource "azurerm_lb_backend_address_pool_address" "n01603990_lb_backend_address" {
  count = length(var.vm_ip_addresses)

  name = "n01603990_lb_backendaddress-%d"
  ip_address = var.vm_ip_addresses[count.index]

  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}

output "load_balancer_name" {
  value = azurerm_lb.n01603990_lb.name
}

