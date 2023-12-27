##creating resource using azure
terraform {
  resource_provider {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.0.0"
    }
  }
}