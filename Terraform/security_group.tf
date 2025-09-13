resource "aws_security_group" "allow_proxy_and_ssh" {
  name        = "allow_proxy_and_ssh"
  description = "Allow SSH and proxy inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.Anwar_VPC_1.id

  tags = {
    Name = "allow_proxy_and_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ingress_proxy" {
  security_group_id = aws_security_group.allow_proxy_and_ssh.id
  cidr_ipv4         = "10.0.1.0/24" # Private Subnet
  from_port         = 3128
  ip_protocol       = "6"
  to_port           = 3128
}

resource "aws_vpc_security_group_ingress_rule" "allow_ingress_ssh_public" {
  security_group_id = aws_security_group.allow_proxy_and_ssh.id
  cidr_ipv4         = "197.163.149.67/32" # my public IP
  from_port         = 22
  ip_protocol       = "6"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_public" {
  security_group_id = aws_security_group.allow_proxy_and_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# ----------------------------------------------------

resource "aws_security_group" "allow_ssh_for_private_subnet" {
  name        = "allow_ssh_for_private_subnet"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.Anwar_VPC_1.id

  tags = {
    Name = "allow_ssh_for_private_subnet"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ingress_ssh_private" {
  security_group_id = aws_security_group.allow_ssh_for_private_subnet.id
  cidr_ipv4         = "10.0.3.0/24" # public subnet IP range
  from_port         = 22
  ip_protocol       = "6"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_private" {
  security_group_id = aws_security_group.allow_ssh_for_private_subnet.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

#----------------------------------------------------------------
