resource "aws_vpc" "this" {
  count = var.create_resource ? 1 : 0

  cidr_block = var.vpc_cidr_block

  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = var.tags
}

resource "aws_vpc_ipv4_cidr_block_association" "this" {
  for_each = var.create_resource ? toset(var.additional_cidr_blocks) : toset([])

  cidr_block = each.value
  vpc_id     = aws_vpc.this[0].id
}

resource "aws_internet_gateway" "this" {
  count = var.create_resource && var.enable_internet_gateway ? 1 : 0

  vpc_id = aws_vpc.this[0].id

  tags = var.tags
}

locals {
  create_dhcp_options = var.dhcp.name != null ? true : false
}

resource "aws_vpc_dhcp_options" "this" {
  count = var.create_resource && local.create_dhcp_options ? 1 : 0

  domain_name          = var.dhcp.name
  domain_name_servers  = var.dhcp.servers
  ntp_servers          = var.dhcp.ntp_servers
  netbios_name_servers = var.dhcp.netbios_name_servers
  netbios_node_type    = 2

  tags = var.tags
}

resource "aws_vpc_dhcp_options_association" "this" {
  count = var.create_resource && local.create_dhcp_options ? 1 : 0

  vpc_id          = aws_vpc.this[0].id
  dhcp_options_id = aws_vpc_dhcp_options.this[0].id
}


