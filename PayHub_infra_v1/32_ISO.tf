
resource "aws_route_table" "ISO1_PUBLIC_ROUTE" {
  vpc_id = aws_vpc.RDSYS_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.RDSYS_IGW.id
  }
  tags = {
      "Name" = "ISO1-PUBLIC-RT"
    }
}
resource "aws_route_table_association" "ISO1_PUBLIC_ASSO" {
  route_table_id = aws_route_table.ISO1_PUBLIC_ROUTE.id
  subnet_id      = aws_subnet.ISO1_PUBLIC_SUBNET.id
}

resource "aws_subnet" "ISO1_PUBLIC_SUBNET" {
  map_public_ip_on_launch = true
  availability_zone       = element(var.az_name_A, 0)
  vpc_id                  = aws_vpc.RDSYS_VPC.id
  cidr_block              = element(var.subnet_cidr_ISO, 0)
  tags = {
      "Name" = "ISO1-PUB-SUBNET-AZ"
    }
}

# ===================================================================================================================

resource "aws_route_table" "ISO2_PRIVATE_ROUTE" {
  vpc_id = aws_vpc.RDSYS_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.RDSYS_IGW.id
  }
  tags = {
      "Name" = "ISO2-PRIVATE-RT"
    }
}
resource "aws_route_table_association" "ISO2_PRIVATE_ASSO" {
  route_table_id = aws_route_table.ISO2_PRIVATE_ROUTE.id
  subnet_id      = aws_subnet.ISO2_PRIVATE_SUBNET.id
}

resource "aws_subnet" "ISO2_PRIVATE_SUBNET" {
  map_public_ip_on_launch = false
  availability_zone       = element(var.az_name_A, 1)
  vpc_id                  = aws_vpc.RDSYS_VPC.id
  cidr_block              = element(var.subnet_cidr_ISO, 1)
  tags = {
      "Name" = "ISO2-PRIV-SUBNET-AZ"
    }
}

