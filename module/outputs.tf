output "network" {
  value = azurerm_virtual_network.vpn
}

output "subnet" {
  value = var.has_default_subnet ? azurerm_subnet.cosmossubnet[0] : null
}
