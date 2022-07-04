# ----------------------------------------------
# Common Variables
# ----------------------------------------------
variable "region" {
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
}

variable "security_group_rules" {
  description = "Security Group rules"
  type        = map(string)
}
