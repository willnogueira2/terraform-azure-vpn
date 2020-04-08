#Terrafrom backend on azure blob (common state between every developper)
#Create an environment variable named ARM_ACCESS_KEY with the value of the Azure Storage access key.
#More here: (https://docs.microsoft.com/en-au/azure/terraform/terraform-backend)
terraform {
  backend "azurerm" {
    resource_group_name  = "terraformstate"
    storage_account_name = "terraformstate2026"
    container_name       = "terraformstate"
    key                  = "virtual-bed-terraform-tfstate"
  }
}

#Defin provider azure
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=2.3.0"
  features {}
}

#Virtual Network
module "azure_vpn" {
  source              = "../../../terraform_modules/azure_vpn"
  context = local.context
}

#cosmos db
module "azure_cosmos" {
  source              = "../../../terraform_modules/azure_cosmos_v1.1"
  context = merge(local.context, {
    resource_location = "Australia East"
  })
}

#function
module "azure_function_consumption"{
  source              = "../../../terraform_modules/azure_function_consumption"
  context = local.context
  WorkerRuntime = "node"

  app_settings = {
    CollectionName                  = "Patients"
    CosmosDB                        = module.azure_cosmos.account.connection_strings[0]
    DBName                          = "VirtualBed"
  }

  connection_strings = [
    {
      name = "AzureCosmosDBConnectionString"
      type = "Custom"
      value = module.azure_cosmos.account.connection_strings[0]
    }
  ]
}