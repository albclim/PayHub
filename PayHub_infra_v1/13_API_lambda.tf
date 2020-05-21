/*
resource "aws_api_gateway_integration" "lambda" {
   rest_api_id = aws_api_gateway_rest_api.API.id
   resource_id = aws_api_gateway_method.proxy.resource_id
   http_method = aws_api_gateway_method.proxy.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   # uri                     = aws_lambda_function.API_LAMBDA.invoke_arn
 }

 resource "aws_api_gateway_method" "proxy_root" {
   rest_api_id   = aws_api_gateway_rest_api.API.id
   resource_id   = aws_api_gateway_rest_api.API.root_resource_id
   http_method   = "ANY"
   authorization = "NONE"
 }

 resource "aws_api_gateway_integration" "lambda_root" {
   rest_api_id = aws_api_gateway_rest_api.API.id
   resource_id = aws_api_gateway_method.proxy_root.resource_id
   http_method = aws_api_gateway_method.proxy_root.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   # uri                     = aws_lambda_function.API_LAMBDA.invoke_arn
 }

resource "aws_api_gateway_deployment" "example" {
   depends_on = [
     aws_api_gateway_integration.lambda,
     aws_api_gateway_integration.lambda_root,
   ]
   rest_api_id = aws_api_gateway_rest_api.API.id
   stage_name  = "test"
 }



/*
# https://www.endava.com/en/blog/Engineering/2019/AWS-serverless-with-Terraform
#lambda.tf
resource "aws_lambda_function" "API" {
    function_name = "${var.environment}-${var.project}"
    s3_bucket = "${var.s3bucket}"
    s3_key  = "v${var.app_version}/${var.s3key}"
    handler = "main.handler"
    runtime = "python3.7"
    role = "${aws_iam_role.lambda_exec.arn}"
}


#iam.tf  -   IAM role which dictates what other AWS services the Lambda function may access.
resource "aws_iam_role" "lambda_exec" {
    name = "${var.environment}_${var.project}"
    assume_role_policy = "${file("iam_role_lambda.json")}"
}


/* iam_role_lambda.json
{
    "Version": "2012-10-17",
    "Statement": [{
        "Action": "sts:AssumeRole",
        "Principal": { "Service": "lambda.amazonaws.com" },
        "Effect": "Allow",
        "Sid": "" } ]
}
*/
