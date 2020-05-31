
resource "aws_route_table" "DIF_PRIVATE_ROUTE" {
  vpc_id = aws_vpc.RDSYS_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.RDSYS_IGW.id
  }

  tags = {
      "Name" = "DIF-PRIVATE-RT"
    }
}

resource "aws_subnet" "DIF_PRIVATE_SUBNET" {
  map_public_ip_on_launch = false
  availability_zone       = element(var.az_name_B, 1)
  vpc_id                  = aws_vpc.RDSYS_VPC.id
  cidr_block              = element(var.subnet_cidr_DIF, 1)
  tags = {
      "Name" = "DIF-PRIV-SUBNET-AZ"
    }
}

resource "aws_route_table_association" "DIF_PRIVATE_ASSO" {
  route_table_id = aws_route_table.DIF_PRIVATE_ROUTE.id
  subnet_id      = aws_subnet.DIF_PRIVATE_SUBNET.id
}
