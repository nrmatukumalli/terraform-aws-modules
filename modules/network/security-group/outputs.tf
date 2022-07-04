output "security_group" {
  description = "AWS Security group details"
  value = {
    id  = aws_security_group.default.id
    arn = aws_security_group.default.arn
  }
}

output "sg_ingress_rules" {
  description = "Ingress Rules added to security group"
  value       = local.all_ingress_rules
}

output "sg_egress_rules" {
  description = "Egress rules added to security group"
  value       = local.all_egress_rules
}
