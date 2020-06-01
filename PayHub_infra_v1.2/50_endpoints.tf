/*
resource "aws_vpc_endpoint" "PAYOL_S3_ENDPOINT" {
  vpc_id          = aws_vpc.PAYOL_1_VPC.id
  service_name    = "com.amazonaws.${var.aws_region_OL}.s3"
  route_table_ids = [aws_route_table.PRI1_PRIVATE_ROUTE.id, aws_route_table.ISO1_PRIVATE_ROUTE.id]
}

resource "aws_vpc_endpoint" "API_S3_ENDPOINT" {
  vpc_id          = aws_vpc.PAYOL_1_VPC.id
  service_name    = "com.amazonaws.${var.aws_region_OL}.s3"
  route_table_ids = [aws_route_table.API_PRIVATE_ROUTE.id]
}
*/
