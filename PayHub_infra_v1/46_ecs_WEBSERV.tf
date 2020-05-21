
resource "aws_instance" "windows_webserver_BACK" {
  associate_public_ip_address          = true
  disable_api_termination              = false
  ami                                  = "ami-08f9a552e55285f32"
  instance_type                        = var.instance_type
  user_data                            = data.template_file.windows-config-template.rendered
  key_name                             = aws_key_pair.generated_key.key_name
  iam_instance_profile                 = aws_iam_instance_profile.app_instance_profile.name
  vpc_security_group_ids               = [aws_security_group.RDSYS_SG.id, aws_security_group.GATE_SG.id]    # ======================SEC GROUP =========================
  subnet_id                            = aws_subnet.BACK_PUBLIC_SUBNET.id
  instance_initiated_shutdown_behavior = "stop"
  tags = {
      "Name" = "BACK-IIS"
    }
  #  Windows WinRM connection
  connection {
    type     = "winrm"
    timeout  = "180m"
    user     = var.temp_windows_user_name
    password = var.temp_windows_user_pass
  }
}

data "template_file" "ubuntu-config-template" {
  template = "${file("${path.module}/user-data/nginx-config.sh")}"
}

resource "aws_instance" "ubuntu_webserver_BACK" {
  associate_public_ip_address          = true
  disable_api_termination              = false
  ami                                  = "ami-08c757228751c5335"
  instance_type                        = var.instance_type
  user_data                            = data.template_file.ubuntu-config-template.rendered
  key_name                             = aws_key_pair.generated_key.key_name
  iam_instance_profile                 = aws_iam_instance_profile.app_instance_profile.name
  vpc_security_group_ids               = [aws_security_group.RDSYS_SG.id, aws_security_group.GATE_SG.id]    # ======================SEC GROUP =========================
  subnet_id                            = aws_subnet.BACK_PUBLIC_SUBNET.id
  instance_initiated_shutdown_behavior = "stop"
  tags = {
      "Name" = "BACK-Nginx"
    }
}