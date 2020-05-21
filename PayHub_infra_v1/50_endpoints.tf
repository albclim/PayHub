
resource "aws_vpc_endpoint" "RDSYS_S3_ENDPOINT" {
  vpc_id          = aws_vpc.RDSYS_VPC.id
  service_name    = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids = [aws_route_table.PRI1_PUBLIC_ROUTE.id, aws_route_table.ISO1_PUBLIC_ROUTE.id]
}

resource "aws_vpc_endpoint" "API_S3_ENDPOINT" {
  vpc_id          = aws_vpc.RDSYS_VPC.id
  service_name    = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids = [aws_route_table.API_PRIVATE_ROUTE.id]
}
