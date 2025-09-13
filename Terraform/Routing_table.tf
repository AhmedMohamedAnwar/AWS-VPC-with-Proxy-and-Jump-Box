#---------Public Route table----------

resource "aws_route_table" "Public_Route" {
  vpc_id = aws_vpc.Anwar_VPC_1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "Public Route Table"
  }
}

#---------attach Public Route table to Subnet Zone 1 ----------

resource "aws_route_table_association" "Public_Subnet_zone1" {
  subnet_id      = aws_subnet.Public_Subnet_zone1.id
  route_table_id = aws_route_table.Public_Route.id
}

#---------attach Public Route table to Subnet Zone 2 ----------

resource "aws_route_table_association" "Public_Subnet_zone2" {
  subnet_id      = aws_subnet.Public_Subnet_zone2.id
  route_table_id = aws_route_table.Public_Route.id

}

#------------------------------------------------------------------

#---------Private Route table----------

# resource "aws_route_table" "Private_Route_NGW1" {
#   vpc_id = aws_vpc.Anwar_VPC_1.id
#   route {
#     cidr_block     = "0.0.0.0/0"
#     network_interface_id = aws_instance.NAT_instance.primary_network_interface_id
#   }
#   tags = {
#     Name = "Private Route"
#   }
# }


# #---------attach Private Route table to Subnet Zone 1 ----------

# resource "aws_route_table_association" "Private_Subnet_zone1" {
#   subnet_id      = aws_subnet.Private_Subnet_zone1.id
#   route_table_id = aws_route_table.Private_Route_NGW1.id
# }

