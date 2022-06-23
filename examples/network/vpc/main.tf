provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = "> 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4"
    }
  }
}

variable "cidr_block" {
  description = "vpc cidr block"
  type = string
}

module "vpc" {
  source = "../../../modules/network/vpc"

  create_resource = true

  company      = "acme"
  organization = "bi"
  environment  = "poc"
  project      = "aap"

  aws_region = "us-east-1"

  cidr_block = var.cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true
  additional_cidr_blocks = []
  domain = {}
}
