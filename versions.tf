terraform {
  required_providers {
    aws = {
      version = "~> 3.0"
      source  = "hashicorp/aws"
    }
    ct = {
      source  = "poseidon/ct"
      version = "0.7.0"
    }
  }
}
