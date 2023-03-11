terraform {
  backend "s3" {
    bucket = "terraforms3backend01"
    key    = "build/aws-terraform-exp2/terraform.tfstate"
    region = "eu-south-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}