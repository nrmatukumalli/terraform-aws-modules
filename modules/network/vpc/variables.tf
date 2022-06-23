# ----------------------------------------------
# Common Variables
# ----------------------------------------------
variable "company" {
  description = "Company name"
  type        = string
  default     = "acme"
}

variable "organization" {
  description = "Business organization or system name within the company"
  type        = string
  default     = "bi"
}

variable "environment" {
  description = "Environment name e.g., 'dev', 'stage', 'prod', 'uat', 'poc'"
  type        = string
  default     = "poc"
}

variable "project" {
  description = "Project/code name with in the organization"
  type        = string
  default     = "aap"
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "Map of key-value pair on the resources"
  type        = map(string)
  default     = {}
}

# ----------------------------------------------
# Module Variables
# ----------------------------------------------

variable "create_resource" {
  description = "Boolean flag to enable/disbale creating resources"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of the resources"
  type        = string
  default     = null
}

variable "cidr_block" {
  description = "(MANDATORY) VPC Cidr Block"
  type        = string
}

variable "instance_tenancy" {
  description = "Tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"

  validation {
    condition     = contains(["default", "dedicated", "host"], var.instance_tenancy)
    error_message = "Instance tenancy must be one of \"default\", \"dedicated\", or \"host\"."
  }
}

variable "enable_dns_hostnames" {
  description = "Boolean flag to enable/disable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Boolean flag to enable/disable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_internet_gateway" {
  description = "Boolean flag to enable/disable Internet gateway"
  type        = bool
  default     = true
}

variable "additional_cidr_blocks" {
  description = "Additional cidr blocks to be associated with the VPC"
  type        = list(string)
  default     = []
}

variable "domain" {
  description = "DHCP domain configuration"
  type = object({
    name                 = string
    servers              = list(string)
    ntp_servers          = list(string)
    netbios_name_servers = list(string)
  })
  default = {}
}
