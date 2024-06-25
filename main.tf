resource "aws_eip" "lb" {
  domain   = "vpc"
}

resource "aws_security_group" "sg" {
  name        = "attribute"
  description = "Allow TLS inbound traffic and all outbound traffic"
} 

resource "aws_vpc_security_group_ingress_rule" "eip" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "${aws_eip.lb.public_ip}/32"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "sg_egress" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "${aws_eip.lb.public_ip}/32"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
