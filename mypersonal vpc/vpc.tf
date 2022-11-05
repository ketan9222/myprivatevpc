#VPC INFORMATION
resource "aws_vpc" "mypersonalvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "main"
  }
}

#public subnet
resource "aws_subnet" "mypublic-subnet-1" {
  vpc_id     = aws_vpc.mypersonalvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "mypublic-subnet-1"
  }
}

resource "aws_subnet" "mypublic-subnet-2" {
  vpc_id     = aws_vpc.mypersonalvpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "mypublic-subnet-2"
  }
}

resource "aws_subnet" "mypublic-subnet-3" {
  vpc_id     = aws_vpc.mypersonalvpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-south-1c"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "mypublic-subnet-3"
  }
}


#private subnet
resource "aws_subnet" "myrivate-subnet-1" {
  vpc_id     = aws_vpc.mypersonalvpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "myprivate-subnet-1"
  }
}

resource "aws_subnet" "myprivate-subnet-2" {
  vpc_id     = aws_vpc.mypersonalvpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "myprivate-subnet-2"
  }
}

resource "aws_subnet" "myprivate-subnet-3" {
  vpc_id     = aws_vpc.mypersonalvpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-south-1c"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "myprivate-subnet-3"
  }
}

#INTERNET gateway

resource "aws_internet_gateway" "myprivatevpc-gw" {
  vpc_id = aws_vpc.mypersonalvpc.id

  tags = {
    Name = "myprivatevpc-gw"
  }
}

#AWS PUBLIC ROUTE TABLE
resource "aws_route_table" "mypersonal-public" {
  vpc_id = aws_vpc.mypersonalvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myprivatevpc-gw.id
  }


  tags = {
    Name = "mypersonal-public"
  }
}
#AWS ROUTE asssociation

resource "aws_route_table_association" "mypersonal-public-1-a" {
  subnet_id      = aws_subnet.mypublic-subnet-1.id
  route_table_id = aws_route_table.mypersonal-public.id
}

resource "aws_route_table_association" "mypersonal-public-2-a" {
  subnet_id      = aws_subnet.mypublic-subnet-2.id
  route_table_id = aws_route_table.mypersonal-public.id
}

resource "aws_route_table_association" "mypersonal-public-3-a" {
  subnet_id      = aws_subnet.mypublic-subnet-3.id
  route_table_id = aws_route_table.mypersonal-public.id
}