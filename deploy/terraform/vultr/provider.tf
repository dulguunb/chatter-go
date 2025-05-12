# provider.tf

terraform {
  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = ">= 2.0" # Use a suitable version constraint
    }
  }
}

provider "vultr" {
  api_key = var.vultr_api_key
}