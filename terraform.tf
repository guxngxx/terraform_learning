// Lab 4.9  - Terraform Configuration Block ---------------------------------------------------------------------
// Lab 4.13 - Terraform Provider Installation -------------------------------------------------------------------
// Lab 4.14 - Multiple Terraform Providers ----------------------------------------------------------------------
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    http = {
      source = "hashicorp/http"
      version = "3.5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.5.3"
    }
  }
}