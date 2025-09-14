resource "aws_network_acl" "Public_NACL" {
  vpc_id = aws_vpc.Anwar_VPC_1.id

  egress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "197.163.149.67/32" # my public IP
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "197.163.149.67/32" # my public IP
    from_port  = 1024
    to_port    = 65535
  }
  # allow ephemeral
  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }


  # ICMP (ping, etc.)
  ingress {
    protocol   = "1" # ICMP
    rule_no    = 130
    action     = "allow"
    cidr_block = "197.163.149.67/32" # my public IP
    from_port  = 0
    to_port    = 0
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 140
    action     = "allow"
    cidr_block = "10.0.1.0/24"
    from_port  = 3128
    to_port    = 3128
  }
  tags = {
    Name = "Public NACL"
  }
}

resource "aws_network_acl_association" "public_assoc" {
  subnet_id      = aws_subnet.Public_Subnet_zone1.id
  network_acl_id = aws_network_acl.Public_NACL.id
}
# -------------------------------------------


resource "aws_network_acl" "Private_NACL" {
  vpc_id = aws_vpc.Anwar_VPC_1.id

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.0.3.0/24"
    from_port  = 22
    to_port    = 22
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "10.0.3.0/24"
    from_port  = 1024
    to_port    = 65535
  }

  egress {
    protocol   = "-1"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  tags = {
    Name = "Private NACL"
  }
}

resource "aws_network_acl_association" "private_assoc" {
  subnet_id      = aws_subnet.Private_Subnet_zone1.id
  network_acl_id = aws_network_acl.Private_NACL.id
}
