#-------Public Subnet Zone 1

resource "aws_subnet" "Public_Subnet_zone1" {
  vpc_id                  = aws_vpc.Anwar_VPC_1.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public subnet zone 1"
  }
}

#-------Public Subnet Zone 2

resource "aws_subnet" "Public_Subnet_zone2" {
  vpc_id                  = aws_vpc.Anwar_VPC_1.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public subnet zone 2"
  }
}