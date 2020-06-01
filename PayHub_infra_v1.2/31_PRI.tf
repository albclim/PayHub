
resource "aws_route_table" "PRI1_PRIVATE_ROUTE" {
  vpc_id = aws_vpc.PAYOL_1_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.PAYOL_IGW.id
  }
  tags = {
      "Name" = "PRI1-PRIVATE-RT"
    }
}
resource "aws_route_table_association" "PRI1_PRIVATE_ASSO" {
  route_table_id = aws_route_table.PRI1_PRIVATE_ROUTE.id
  subnet_id      = aws_subnet.PRI1_PRIVATE_SUBNET.id
}
resource "aws_subnet" "PRI1_PRIVATE_SUBNET" {
  map_public_ip_on_launch = true
  availability_zone       = element(var.az_name_A, 0)
  vpc_id                  = aws_vpc.PAYOL_1_VPC.id
  cidr_block              = element(var.subnet_cidr_PRI, 0)
#  depends_on              = [aws_internet_gateway.PRISO1_IGW]
  tags = {
      "Name" = "PRI1-PRIV-SUBNET-AZ"
    }
}

# ===================================================================================================================

resource "aws_route_table" "PRI2_PRIVATE_ROUTE" {
  vpc_id = aws_vpc.PAYOL_1_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.PAYOL_IGW.id
  }
  tags = {
      "Name" = "PRI2-PRIVATE-RT"
    }
}
resource "aws_route_table_association" "PRI2_PRIVATE_ASSO" {
  route_table_id = aws_route_table.PRI2_PRIVATE_ROUTE.id
  subnet_id      = aws_subnet.PRI2_PRIVATE_SUBNET.id
}
resource "aws_subnet" "PRI2_PRIVATE_SUBNET" {
  map_public_ip_on_launch = false
  availability_zone       = element(var.az_name_A, 1)
  vpc_id                  = aws_vpc.PAYOL_1_VPC.id
  cidr_block              = element(var.subnet_cidr_PRI, 1)
#  depends_on              = [aws_internet_gateway.PRISO1_IGW]
  tags = {
      "Name" = "PRI2-PRIV-SUBNET-AZ"
    }
}

# ======================================= REGLAS DE ACCESO DE RED =====================================================

