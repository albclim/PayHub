
resource "aws_route_table" "ISO1_PRIVATE_ROUTE" {
  vpc_id = aws_vpc.PAYOL_1_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.PAYOL_IGW.id
  }
  tags = {
      "Name" = "ISO1-PUBLIC-RT"
    }
}
resource "aws_route_table_association" "ISO1_PRIVATE_ASSO" {
  route_table_id = aws_route_table.ISO1_PRIVATE_ROUTE.id
  subnet_id      = aws_subnet.ISO1_PRIVATE_SUBNET.id
}

resource "aws_subnet" "ISO1_PRIVATE_SUBNET" {
  map_public_ip_on_launch = true
  availability_zone       = element(var.az_name_A, 0)
  vpc_id                  = aws_vpc.PAYOL_1_VPC.id
  cidr_block              = element(var.subnet_cidr_ISO, 0)
#  depends_on              = [aws_internet_gateway.PRISO2_IGW]
  tags = {
      "Name" = "ISO1-PRIV-SUBNET-AZ"
    }
}

# ===================================================================================================================

resource "aws_route_table" "ISO2_PRIVATE_ROUTE" {
  vpc_id = aws_vpc.PAYOL_1_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.PAYOL_IGW.id
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
  vpc_id                  = aws_vpc.PAYOL_1_VPC.id
  cidr_block              = element(var.subnet_cidr_ISO, 1)
#  depends_on              = [aws_internet_gateway.PRISO2_IGW]
  tags = {
      "Name" = "ISO2-PRIV-SUBNET-AZ"
    }
}