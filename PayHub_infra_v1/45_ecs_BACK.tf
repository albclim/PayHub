
resource "aws_instance" "BACK" {
  associate_public_ip_address          = true
  disable_api_termination              = false
  ami                                  = "ami-08f9a552e55285f32"
  instance_type                        = var.instance_type
  user_data                            = data.template_file.win16-config-template.rendered
  key_name                             = aws_key_pair.generated_key.key_name
  iam_instance_profile                 = aws_iam_instance_profile.app_instance_profile.name
  vpc_security_group_ids               = [aws_security_group.GATE_SG.id]
  subnet_id                            = aws_subnet.BACK_PUBLIC_SUBNET.id
  instance_initiated_shutdown_behavior = "stop"
  tags = {
      "Name" = "BACK"
  }
  # Windows WinRM connection
  connection {
    type     = "winrm"
    timeout  = "180m"
    user     = var.temp_windows_user_name
    password = var.temp_windows_user_pass
  }
}
