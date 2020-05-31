
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
resource "aws_route_table_association" "BACK_PUBLIC_ASSO" {
  route_table_id = aws_route_table.BACK_PUBLIC_ROUTE.id
  subnet_id      = aws_subnet.BACK_PUBLIC_SUBNET.id
}


resource "aws_subnet" "BACK_PUBLIC_SUBNET" {
  map_public_ip_on_launch = false
  availability_zone       = element(var.az_name_C, 0)
  vpc_id                  = aws_vpc.RDSYS_VPC.id
  cidr_block              = element(var.subnet_cidr_BACK, 1)
  tags = {
      "Name" = "BACK-PRIV-SUBNET-AZ"
    }
}
