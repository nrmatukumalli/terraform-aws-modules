locals {
  rules_map    = { for i, rule in var.sg_rules : tostring(i) => rule }
  ingress_keys = compact([for i, rule in local.rules_map : rule.type == "ingress" ? i : ""])
  egress_keys  = compact([for i, rule in local.rules_map : rule.type == "egress" ? i : ""])

  all_ingress_rules = [for key in local.rules_map : lookup(local.rules_map, key)]
  all_egress_rules  = [for key in local.rules_map : lookup(local.rules_map, key)]
}

resource "aws_security_group" "default" {
  count = var.create_resource ? 1 : 0

  name        = var.sg_name
  description = var.sg_description

  vpc_id = var.vpc_id

  revoke_rules_on_delete = var.revoke_rules_on_delete

  dynamic "egress" {
    for_each = toset(local.all_egress_rules)

    content {
      from_port        = egress.value.from_port
      to_port          = egress.value.to_port
      protocol         = egress.value.protocol
      description      = egress.value.description
      cidr_blocks      = egress.value.cidr_blocks
      ipv6_cidr_blocks = egress.value.ipv6_cidr_blocks
      prefix_list_ids  = egress.value.prefix_list_ids
      security_groups  = egress.value.security_group_ids
      self             = egress.value.self

    }
  }

  dynamic "ingress" {
    for_each = toset(local.all_ingress_rules)

    content {
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      description      = ingress.value.description
      cidr_blocks      = ingress.value.cidr_blocks
      ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks
      prefix_list_ids  = ingress.value.prefix_list_ids
      security_groups  = ingress.value.security_group_ids
      self             = ingress.value.self

    }
  }

  tags = var.tags

  timeouts {
    create = var.create_timeout
    delete = var.delete_timeout
  }
}
