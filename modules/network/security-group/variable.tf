# ----------------------------------------------
# Common Variables
# ----------------------------------------------
variable "context" {
  description = "Naming/Project context"
  type = object({
    company      = string
    organization = string
    project      = string
    enivronment  = string
  })
  default = {
    company      = "mnr"
    enivronment  = "poc"
    organization = "analytics"
    project      = "aas"
  }
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

variable "description" {
  description = "Security group description"
  type        = string
  default     = "Manged by Terraform"
}

variable "vpc_id" {
  description = "VPC id the security group belongs to"
  type        = string
  default     = null
}

variable "revoke_rules_on_delete" {
  description = "Revoke rules of security group on delete"
  type        = bool
  default     = false
}

variable "security_group_rules" {
  description = "security group rules to be added to the security group"
  type = list(object({
    type               = string
    from_port          = number
    to_port            = number
    protocol           = string
    cidr_blocks        = list(string)
    ipv6_cidr_blocks   = list(string)
    prefix_list_ids    = list(string)
    security_group_ids = list(string)
    self               = bool
    description        = string
  }))
  default = []
}

variable "create_timeout" {
  description = "Security group create timeout"
  type        = string
  default     = "10m"
}

variable "delete_timeout" {
  description = "Security group delete timeout"
  type        = string
  default     = "15m"
}
