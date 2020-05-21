
resource "aws_route_table" "API_PRIVATE_ROUTE" {
  vpc_id = aws_vpc.RDSYS_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.RDSYS_IGW.id
  }

  tags = {
      "Name" = "API-PRIVATE-RT"
    }
}

resource "aws_subnet" "API_PRIVATE_SUBNET" {
  map_public_ip_on_launch = false
  availability_zone       = element(var.az_name_A, 0)
  vpc_id                  = aws_vpc.RDSYS_VPC.id
  cidr_block              = element(var.subnet_cidr_API, 1)
#  depends_on              = [aws_internet_gateway.API_IGW]
  tags = {
      "Name" = "API-PRIV-SUBNET-AZ"
    }
}

resource "aws_route_table_association" "API_PRIVATE_ASSO" {
  route_table_id = aws_route_table.API_PRIVATE_ROUTE.id
  subnet_id      = aws_subnet.API_PRIVATE_SUBNET.id
}


# ================================================= GATEWAY API ====================

resource "aws_api_gateway_rest_api" "API" {
  name        = "API"
  description = "API-GW"
  endpoint_configuration {
      types = ["EDGE"]
  }
}

resource "aws_api_gateway_resource" "proxy" {
   rest_api_id = aws_api_gateway_rest_api.API.id
   parent_id   = aws_api_gateway_rest_api.API.root_resource_id
   path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
   rest_api_id   = aws_api_gateway_rest_api.API.id
   resource_id   = aws_api_gateway_resource.proxy.id
   http_method   = "ANY"
   authorization = "NONE"
}


#resource "aws_internet_gateway" "API_IGW" {
#  vpc_id = aws_vpc.RDSYS_VPC.id
#  tags = {
#      "Name" = "API-IGW"
#    }
#}