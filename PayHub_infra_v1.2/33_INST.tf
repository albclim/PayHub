
resource "aws_route_table" "INST1_PRIVATE_ROUTE" {
  vpc_id = aws_vpc.PAYOL_1_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.PAYOL_IGW.id
  }
  tags = {
      "Name" = "INST1-PUBLIC-RT"
    }
}
resource "aws_route_table_association" "INST1_PRIVATE_ASSO" {
  route_table_id = aws_route_table.INST1_PRIVATE_ROUTE.id
  subnet_id      = aws_subnet.INST1_PRIVATE_SUBNET.id
}

resource "aws_subnet" "INST1_PRIVATE_SUBNET" {
  map_public_ip_on_launch = true
  availability_zone       = element(var.az_name_A, 0)
  vpc_id                  = aws_vpc.PAYOL_1_VPC.id
  cidr_block              = element(var.subnet_cidr_INST, 0)
#  depends_on              = [aws_internet_gateway.PRISO1_IGW]
  tags = {
      "Name" = "INST1-PUB-SUBNET-AZ"
    }
}

# ===================================================================================================================

resource "aws_route_table" "INST2_PRIVATE_ROUTE" {
  vpc_id = aws_vpc.PAYOL_1_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.PAYOL_IGW.id
  }
  tags = {
      "Name" = "INST2-PRIVATE-RT"
    }
}
resource "aws_route_table_association" "INST2_PRIVATE_ASSO" {
  route_table_id = aws_route_table.INST2_PRIVATE_ROUTE.id
  subnet_id      = aws_subnet.INST2_PRIVATE_SUBNET.id
}

resource "aws_subnet" "INST2_PRIVATE_SUBNET" {
  map_public_ip_on_launch = false
  availability_zone       = element(var.az_name_A, 1)
  vpc_id                  = aws_vpc.PAYOL_1_VPC.id
  cidr_block              = element(var.subnet_cidr_INST, 1)
#  depends_on              = [aws_internet_gateway.PRISO1_IGW]
  tags = {
      "Name" = "INST2-PRIV-SUBNET-AZ"
    }
}
