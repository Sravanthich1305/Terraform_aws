###creating of azure resource
terraform {
  required_provider {
    aws  = {
    source = "hashicorp/aws"
    version = "~>5.0 "
    }
  }
}