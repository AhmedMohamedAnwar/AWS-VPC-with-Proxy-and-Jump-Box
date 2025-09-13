#-------Private Subnet Zone 1

resource "aws_subnet" "Private_Subnet_zone1" {
  vpc_id            = aws_vpc.Anwar_VPC_1.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Private subnet zone 1"
  }
}

#-------Private Subnet Zone 2

resource "aws_subnet" "Private_Subnet_zone2" {
  vpc_id            = aws_vpc.Anwar_VPC_1.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Private subnet zone 2"
  }
}