provider "aws" {
  region = local.region
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

locals {
  region = "us-east-1"
  tags = {
    Owner   = "Veera V Nageswara Rao"
    Company = "ACME"
  }
}

module "sg" {
  source = "../../../modules/network/security-group"

  create_resource = true
  region          = local.region

  sg_name        = "default-sg"
  sg_description = "Managed By Terraform"
  sg_rules       = []

  revoke_rules_on_delete = true

  vpc_id = ""

  create_timeout = "10m"
  delete_timeout = "15m"

  tags = local.tags
}
