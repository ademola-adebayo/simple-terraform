# Create AWS VPC
resource "aws_vpc" "development-vpc" {
  cidr_block   = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name: "development"
  }
}

data "aws_availability_zones" "available" {}

# Public subnets for VPC
resource "aws_subnet" "dev-public-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block   = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2a"

  tags = {
    Name: "dev-public-subnet-1"
  }
}

resource "aws_subnet" "dev-public-subnet-2" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block   = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2b"

  tags = {
    Name: "dev-public-subnet-2"
  }
}

resource "aws_subnet" "dev-public-subnet-3" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block   = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2c"

  tags = {
    Name: "dev-public-subnet-3"
  }
}

# Private subnets for VPC
resource "aws_subnet" "dev-private-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block   = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-2a"

  tags = {
    Name: "dev-private-subnet-1"
  }
}

resource "aws_subnet" "dev-private-subnet-2" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block   = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-2b"

  tags = {
    Name: "dev-private-subnet-2"
  }
}

resource "aws_subnet" "dev-private-subnet-3" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block   = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-2c"

  tags = {
    Name: "dev-private-subnet-3"
  }
}


#Create Internet Gateway
resource "aws_internet_gateway" "dev-GW" {
   vpc_id = aws_vpc.development-vpc.id
   
   tags = {
     Name = "dev-GW"
   }
}

#Routing Table for the Custom VPC
resource "aws_route_table" "dev-public-RT" {
   vpc_id = aws_vpc.development-vpc.id
   
   route {
     cidr_block  = "0.0.0.0/0"
     gateway_id   = aws_internet_gateway.dev-GW.id
   }

   tags = {
     Name = "dev-public-RT"
   }
}
i
# Route Associations Private
resource "aws_route_table_association" "dev-public-1-RTA" {
   subnet_id       = aws_subnet.dev-public-subnet-1.id
   route_table_id  = aws_route_table.dev-public-RT.id
}

resource "aws_route_table_association" "dev-public-2-RTA" {
   subnet_id       = aws_subnet.dev-public-subnet-2.id
   route_table_id  = aws_route_table.dev-public-RT.id
}

resource "aws_route_table_association" "dev-public-3-RTA" {
   subnet_id       = aws_subnet.dev-public-subnet-3.id
   route_table_id  = aws_route_table.dev-public-RT.id
}


output "dev-public-subnet-id" {
   value = aws_subnet.dev-subnet.id
}

output "dev-vpc-id" {
   value = aws_vpc.development-vpc.id
}

