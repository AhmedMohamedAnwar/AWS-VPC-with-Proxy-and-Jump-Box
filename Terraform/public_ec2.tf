# Create Public Instance

resource "aws_instance" "Public_instance" {
  ami                    = data.aws_ami.amazon_linux.id
  subnet_id              = aws_subnet.Public_Subnet_zone1.id
  instance_type          = "t2.micro"
  key_name               = "ssh-key"
  vpc_security_group_ids = [aws_security_group.allow_ssh_and_port5000.id]

  tags = {
    Name = "Public Instace"
  }
}

# Create Proxy Instance 

resource "aws_instance" "Proxy_instance" {
  ami                    = data.aws_ami.amazon_linux.id
  subnet_id              = aws_subnet.Public_Subnet_zone1.id
  instance_type          = "t2.micro"
  key_name               = "ssh-key"
  vpc_security_group_ids = [aws_security_group.allow_proxy.id]

  tags = {
    Name = "Proxy Instace"
  }
}