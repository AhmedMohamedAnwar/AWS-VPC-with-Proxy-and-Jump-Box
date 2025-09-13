resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.Anwar_VPC_1.id
  tags = {
    Name = "IGW"
  }
}
