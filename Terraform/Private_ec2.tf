# Search for amazon linux AMI

data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  owners = ["amazon"]
}

# Create Private Instance

resource "aws_instance" "private_instance" {
  ami                    = data.aws_ami.amazon_linux.id
  subnet_id              = aws_subnet.Private_Subnet_zone1.id
  vpc_security_group_ids = [aws_security_group.allow_ssh_for_private_subnet.id]
  key_name               = "ssh-key"
  instance_type          = "t2.micro"
  tags = {
    Name = "Private Instace"
  }
}

