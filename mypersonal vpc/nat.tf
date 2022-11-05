#DEFINE NAT instance
resource "aws-eip" "myprivate-nat"  {
    vpc = true
}


#AWS NAT gateway
resource "aws_nat_gateway" "myprivate-nat-gw" {
  allocation_id = aws_eip.myprivate-nat-gw.id
  subnet_id     = aws_subnet.mypublic-subnet-1.id
  depends_on = [aws_internet_gateway.myprivatevpc-gw]

  tags = {
    Name = "gw NAT"
  }

#PRIVAte route Table
resource "aws_route_table" "mypersonal-private" {
  vpc_id = aws_vpc.mypersonalvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.myprivate-nat-gw.id
  }

  tags = {
    Name = "mypersonal-private"
  }
}

#aws route asssociation
resource "aws_route_table_association" "myrivate-subnet-1-a" {
  subnet_id      = aws_subnet.myrivate-subnet-1.id
  route_table_id = aws_route_table.mypersonal-private.id
}

resource "aws_route_table_association" "myrivate-subnet-2-a" {
  subnet_id      = aws_subnet.myrivate-subnet-2.id
  route_table_id = aws_route_table.mypersonal-private.id
}

resource "aws_route_table_association" "myrivate-subnet-3-a" {
  subnet_id      = aws_subnet.myrivate-subnet-3.id
  route_table_id = aws_route_table.mypersonal-private.id
}

