
resource "aws_instance" "PRI_1" {
  associate_public_ip_address          = true
  disable_api_termination              = false
  ami                                  = "ami-08f9a552e55285f32"
  instance_type                        = var.instance_type_OL
  user_data                            = data.template_file.win16-1-config-template.rendered
  key_name                             = aws_key_pair.generated_key.key_name
  iam_instance_profile                 = aws_iam_instance_profile.app_instance_profile.name
  vpc_security_group_ids               = [aws_security_group.PAYOL_SG.id]
  subnet_id                            = aws_subnet.PRI1_PRIVATE_SUBNET.id
  instance_initiated_shutdown_behavior = "stop"
  tags = {
      "Name" = "PRI-1"
    }
  connection {
    type     = "winrm"
    timeout  = "180m"
    user     = var.temp_windows_user_name
    password = var.temp_windows_user_pass
  }
}

resource "aws_instance" "PRI_2" {
  associate_public_ip_address          = true
  disable_api_termination              = false
  ami                                  = "ami-08c757228751c5335"
  instance_type                        = var.instance_type_OL
  user_data                            = data.template_file.ubuntu-config-template.rendered
  key_name                             = aws_key_pair.generated_key.key_name
  iam_instance_profile                 = aws_iam_instance_profile.app_instance_profile.name
  vpc_security_group_ids               = [aws_security_group.PAYOL_SG.id]
  subnet_id                            = aws_subnet.PRI2_PRIVATE_SUBNET.id
  instance_initiated_shutdown_behavior = "stop"
  tags = {
      "Name" = "PRI-2"
    }
  connection {
    type     = "winrm"
    timeout  = "180m"
    user     = var.temp_windows_user_name
    password = var.temp_windows_user_pass
  }
}