terraform {
  backend "s3" {
    bucket = "YOUR-Terraform-S3-Backend-HERE"
    key    = "build/aws-terraform-test/terraform.tfstate"
    region = "YOU-Account-Region-HERE"
  }
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}