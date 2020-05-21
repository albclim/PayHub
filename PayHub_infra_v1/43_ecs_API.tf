
resource "aws_instance" "API_server" {
  associate_public_ip_address          = false
  disable_api_termination              = false
  ami                                  = "ami-08f9a552e55285f32"
  instance_type                        = var.instance_type
  user_data                            = data.template_file.windows-config-template.rendered
  key_name                             = aws_key_pair.generated_key.key_name
  iam_instance_profile                 = aws_iam_instance_profile.app_instance_profile.name
  vpc_security_group_ids               = [aws_security_group.RDSYS_SG.id]    # ======================SEC GROUP =========================
  subnet_id                            = aws_subnet.API_PRIVATE_SUBNET.id
  instance_initiated_shutdown_behavior = "stop"
  tags = {
      "Name" = "API"
  }
  #  Windows WinRM connection
  connection {
    type     = "winrm"
    timeout  = "180m"
    user     = var.temp_windows_user_name
    password = var.temp_windows_user_pass
  }
}

# ================================================= FUNCTION LAMBDA  ----------  REVISAR =========================================

# https://gist.github.com/smithclay/e026b10980214cbe95600b82f67b4958

/*
// 'Hello World' nodejs6.10 runtime AWS Lambda function

FICHERO index.js - guarada en user_data y poner ruta en source file
exports.handler = (event, context, callback) => {
    console.log('Hello, logs!');
    callback(null, 'great success');
}
*/
/*
resource "aws_iam_role" "iam_for_lambda_tf" {
  name = "iam_for_lambda_tf"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "archive_file" "lambda_zip" {
    type          = "zip"
    source_file   = "index.js"
    output_path   = "lambda_function.zip"
}

resource "aws_lambda_function" "API_LAMBDA" {
  filename         = "lambda_function.zip"
  function_name    = "API_lambda"
  role             = "aws_iam_role.iam_for_lambda_tf.arn"
  handler          = "index.handler"
  source_code_hash = "data.archive_file.lambda_zip.output_base64sha256"
  runtime          = "nodejs6.10"
  environment {
    variables = {
      foo = "bar"
      }
    }
}
*/