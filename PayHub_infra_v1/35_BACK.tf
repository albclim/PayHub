
resource "aws_route_table" "BACK_PUBLIC_ROUTE" {
  vpc_id = aws_vpc.RDSYS_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.RDSYS_IGW.id
  }
  tags = {
      "Name" = "BACK-PUBLIC-RT"
    }
}
resource "aws_route_table_association" "BACK_PUBLIC_ASSO" {    # ESTO DEBERA SER PUBLIC
  route_table_id = aws_route_table.BACK_PUBLIC_ROUTE.id
  subnet_id      = aws_subnet.BACK_PUBLIC_SUBNET.id
}


resource "aws_subnet" "BACK_PUBLIC_SUBNET" {     # ESTO DEBERA SER PUBLIC
  map_public_ip_on_launch = false
  availability_zone       = element(var.az_name_C, 0)
  vpc_id                  = aws_vpc.RDSYS_VPC.id
  cidr_block              = element(var.subnet_cidr_BACK, 1)
#  depends_on              = [aws_internet_gateway.BACK_IGW]
  tags = {
      "Name" = "BACK-PRIV-SUBNET-AZ"
    }
}

# ======================================= REGLAS DE ACCESO DE RED =====================================================



/*
resource "aws_internet_gateway" "BACK_IGW" {
  vpc_id = aws_vpc.RDSYS_VPC.id
  tags = {
      "Name" = "BACK-IGW"
    }
}

resource "aws_nat_gateway" "DIF_NAT" {
  subnet_id     = aws_subnet.DIF_PUBLIC_SUBNET.id
  allocation_id = aws_eip.APP_EIP.id
  # depends_on    = [aws_internet_gateway.DIF_IGW]
  tags = {
      "Name" = "DIF-NGW"
    }
}
*/