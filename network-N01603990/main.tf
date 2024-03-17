resource "azurerm_virtual_network" "n01603990_vnet" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.humberid_rg.location

  resource_group_name = azurerm_resource_group.humberid_rg.name

  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}

resource "azurerm_subnet" "n01603990_subnet" {
  name                  = var.subnet_name
  resource_group_name    = azurerm_resource_group.humberid_rg.name
  virtual_network_name  = azurerm_virtual_network.n01603990_vnet.name
  address_prefixes      = ["10.0.1.0/24"]

  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}

resource "azurerm_network_security_group" "n01603990_nsg" {
  name                = var.network_security_group_name
  location            = azurerm_resource_group.humberid_rg.location
  resource_group_name = azurerm_resource_group.humberid_rg.name

  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}

resource "azurerm_network_security_rule" "n01603990_nsg_rule" {
  count               = 4
  name                = format("%s-rule-%d", var.network_security_group_name, count.index)
  priority            = count.index
  direction           = "Inbound"
  source_address_prefix      = "*"
  source_port_ranges   = [""]
  destination_address_prefix = "*"
  destination_port_ranges    = [format("%d", var.allowed_ports[count.index])]
  access              = "Allow"
  protocol             = "Tcp"

  network_security_group_id = azurerm_network_security_group.n01603990_nsg.id

  tags = {
    Assignment  = "CCGC 5502 Automation Assignment"
    Name        = var.name
    Environment = "Learning"
    ExpirationDate = "2024-12-31"
  }
}
# Inside network-N01603990/main.tf

output "subnet_id" {
  # Name the output appropriately (e.g., subnet_id)
  value = azurerm_subnet.n01603990_subnet.id
}

