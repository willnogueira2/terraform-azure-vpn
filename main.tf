#Virtual Network
resource "azurerm_virtual_network" "vpn" {
  name                = "${local.project_env}-vpn"
  resource_group_name  = var.context.resource_group_name
  location             = var.context.resource_location
  address_space       = ["10.1.0.0/16"]
  tags = {
    project_env = local.project_env
  }
}

resource "azurerm_subnet" "cosmossubnet" {
  count                = var.has_default_subnet ? 1 : 0
  name                 = "default"
  resource_group_name  = var.context.resource_group_name
  virtual_network_name = azurerm_virtual_network.vpn.name
  address_prefix       = "10.1.0.0/24"
  service_endpoints    = [
    "Microsoft.AzureActiveDirectory",
    "Microsoft.AzureCosmosDB",
    "Microsoft.ContainerRegistry",
    "Microsoft.EventHub",
    "Microsoft.KeyVault",
    "Microsoft.ServiceBus",
    "Microsoft.Sql",
    "Microsoft.Storage",
    "Microsoft.Web",
  ]
  depends_on          = [azurerm_virtual_network.vpn]
}