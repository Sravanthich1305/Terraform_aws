##resource
terraform {
  required_provider {
     aws {
        source = "hashicorp/aws"
        version = "~>5.0"
     }
  }
}

#############
#resouce for azure

terraform {
  resource_provider {
     azurerm {
       source = "hashicorp/azure"
       version = "3.0.0"
     }
  }
}