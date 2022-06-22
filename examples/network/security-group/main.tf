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

module "sg" {
  source = "github.com/myawsanalytics/terraform-aws-modules//modules/network/security-group"

  create_resource = true

  company      = "acme"
  organization = "bi"
  environment  = "poc"
  project      = "aap"

  aws_region = "us-east-1"

  vpc_id = ""

  name                   = null
  description            = "Managed By Terraform"
  revoke_rules_on_delete = true
  security_group_rules   = []

  create_timeout = "10m"
  delete_timeout = "15m"

  tags = {}
}
