resource "aws_security_group" "appstream_security_group" {
  name   = var.appstream_security_group
  vpc_id = var.appstream_vpc_id
}

# Ingress rules driven by ingress_cidr_blocks list
resource "aws_vpc_security_group_ingress_rule" "allow_inbound" {
  for_each = toset(var.ingress_cidr_blocks)

  security_group_id = aws_security_group.appstream_security_group.id
  cidr_ipv4         = each.key
  from_port         = var.ingress_from_port
  to_port           = var.ingress_to_port
  ip_protocol       = var.ingress_protocol
}

# Egress rules driven by egress_cidr_blocks list
resource "aws_vpc_security_group_egress_rule" "allow_outbound" {
  for_each = toset(var.egress_cidr_blocks)

  security_group_id = aws_security_group.appstream_security_group.id
  cidr_ipv4         = each.key
  ip_protocol       = var.egress_protocol
}
