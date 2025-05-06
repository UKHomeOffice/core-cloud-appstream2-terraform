resource "aws_security_group" "appstream_security_group" {
  name   = var.appstream_security_group
  vpc_id = var.appstream_vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_inbbound" {
  security_group_id = aws_security_group.appstream_security_group.id

  cidr_ipv4   = "10.111.3.0/24"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.appstream_security_group.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}
