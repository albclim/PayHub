
resource "aws_route_table" "PRI1_PUBLIC_ROUTE" {
  vpc_id = aws_vpc.RDSYS_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.RDSYS_IGW.id
  }
  tags = {
      "Name" = "PRI1-PUBLIC-RT"
    }
}
resource "aws_route_table_association" "PRI1_PUBLIC_ASSO" {
  route_table_id = aws_route_table.PRI1_PUBLIC_ROUTE.id
  subnet_id      = aws_subnet.PRI1_PUBLIC_SUBNET.id
}

resource "aws_subnet" "PRI1_PUBLIC_SUBNET" {
  map_public_ip_on_launch = true
  availability_zone       = element(var.az_name_A, 0)
  vpc_id                  = aws_vpc.RDSYS_VPC.id
  cidr_block              = element(var.subnet_cidr_PRI, 0)   # ============== PROBANDO CIDR BLOCK
#  depends_on              = [aws_internet_gateway.PRISO1_IGW]
  tags = {
      "Name" = "PRI1-PUB-SUBNET-AZ"
    }
}

# ===================================================================================================================

resource "aws_route_table" "PRI2_PRIVATE_ROUTE" {
  vpc_id = aws_vpc.RDSYS_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.RDSYS_IGW.id
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
  vpc_id                  = aws_vpc.RDSYS_VPC.id
  cidr_block              = element(var.subnet_cidr_PRI, 1)
#  depends_on              = [aws_internet_gateway.PRISO1_IGW]
  tags = {
      "Name" = "PRI2-PRIV-SUBNET-AZ"
    }
}

# ======================================= REGLAS DE ACCESO DE RED =====================================================


/*
resource "aws_internet_gateway" "PRISO1_IGW" {     # ===== ESTA IGW ES PARA SUBNET PUBLICA DE PRI & ISO
  vpc_id = aws_vpc.RDSYS_VPC.id
  tags = {
      "Name" = "PRISO1-IGW"
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