# Create AWS SG for Proxy Instances

resource "aws_security_group" "allow_proxy" {
  name        = "allow_proxy"
  description = "Allow proxy inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.Anwar_VPC_1.id

  tags = {
    Name = "allow_proxy"
  }
}

# allow ingress port 3128 for private subnet

resource "aws_vpc_security_group_ingress_rule" "allow_ingress_proxy" {
  security_group_id = aws_security_group.allow_proxy_and_ssh.id
  cidr_ipv4         = "10.0.1.0/24" # Private Subnet
  from_port         = 3128
  ip_protocol       = "6"
  to_port           = 3128
}


# Allow egress for all

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_public" {
  security_group_id = aws_security_group.allow_proxy_and_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# --------------------------------------------------------------------
# Create SG for jump box

resource "aws_security_group" "allow_ssh_and_port5000" {
  name        = "allow_ssh"
  description = "Allow ssh and port 5000 inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.Anwar_VPC_1.id

  tags = {
    Name = "allow_ssh"
  }
}

# Allow ingress port 5000 for my laptop for ssh tunnel 

resource "aws_vpc_security_group_ingress_rule" "allow_ingress_port5000_public" {
  security_group_id = aws_security_group.allow_proxy_and_ssh.id
  cidr_ipv4         = "197.163.149.67/32" # my public IP
  from_port         = 5000
  ip_protocol       = "6"
  to_port           = 5000
}

# Allow ssh for my laptop
resource "aws_vpc_security_group_ingress_rule" "allow_ingress_ssh_public" {
  security_group_id = aws_security_group.allow_proxy_and_ssh.id
  cidr_ipv4         = "197.163.149.67/32" # my public IP
  from_port         = 22
  ip_protocol       = "6"
  to_port           = 22
}

# --------------------------------------------------------------------
# Create AWS SG for Private subnets

resource "aws_security_group" "allow_ssh_for_private_subnet" {
  name        = "allow_ssh_for_private_subnet"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.Anwar_VPC_1.id

  tags = {
    Name = "allow_ssh_for_private_subnet"
  }
}

# Allow Ingress for port 22

resource "aws_vpc_security_group_ingress_rule" "allow_ingress_ssh_private" {
  security_group_id = aws_security_group.allow_ssh_for_private_subnet.id
  cidr_ipv4         = "10.0.3.0/24" # public subnet IP range
  from_port         = 22
  ip_protocol       = "6"
  to_port           = 22
}

# Allow Ingress for port 5000

resource "aws_vpc_security_group_ingress_rule" "allow_ingress_port5000_private" {
  security_group_id = aws_security_group.allow_ssh_for_private_subnet.id
  cidr_ipv4         = "10.0.3.0/24" # public subnet IP range
  from_port         = 5000
  ip_protocol       = "6"
  to_port           = 5000
}

# Allow egress for all

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_private" {
  security_group_id = aws_security_group.allow_ssh_for_private_subnet.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
