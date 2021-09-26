#Define External IP
resource "aws_eip" "dev-NAT" {
   vpc = true
}


resource "aws_nat_gateway" "dev-NAT-GW" {
  allocation_id  = aws_eip.dev-NAT.id
  subnet_id      = aws_subnet.dev-public-subnet-1.id
  depends_on     = [aws_internet_gateway.dev-GW]
}


resource "aws_route_table" "dev-private" {
  vpc_id  = aws_vpc.development-vpc.id
  route {
   cidr_block  = "0.0.0.0/0"
nat_gateway_id  = aws_nat_gateway.dev-NAT-GW
  }

  tags = {
   Name = "dev-private"
  }
}

# Route Association Private 
resource "aws_route_table_association" "dev-private-1-RTA" {
   subnet_id       = aws_subnet.dev-private-subnet-1.id
   route_table_id  = aws_route_table.dev-private-RT.id
}

resource "aws_route_table_association" "dev-private-2-RTA" {
   subnet_id       = aws_subnet.dev-private-subnet-2.id
   route_table_id  = aws_route_table.dev-private-RT.id
}

resource "aws_route_table_association" "dev-private-3-RTA" {
   subnet_id       = aws_subnet.dev-private-subnet-3.id
   route_table_id  = aws_route_table.dev-private-RT.id
}
