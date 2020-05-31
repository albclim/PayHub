resource "aws_instance" "DIF_server" {
  associate_public_ip_address          = false
  disable_api_termination              = false
  ami                                  = "ami-08f9a552e55285f32"
  instance_type                        = var.instance_type
  user_data                            = data.template_file.windows-config-template.rendered
  key_name                             = aws_key_pair.generated_key.key_name
  iam_instance_profile                 = aws_iam_instance_profile.app_instance_profile.name
  vpc_security_group_ids               = [aws_security_group.RDSYS_SG.id]
  subnet_id                            = aws_subnet.DIF_PRIVATE_SUBNET.id
  instance_initiated_shutdown_behavior = "stop"
  tags = {
      "Name" = "DIF"
  }
  #  Windows WinRM connection
  connection {
    type     = "winrm"
    timeout  = "180m"
    user     = var.temp_windows_user_name
    password = var.temp_windows_user_pass
  }
}

resource "aws_efs_file_system" "DIF_EFS" {
    creation_token   = "DIF-EFS"
    performance_mode = "generalPurpose"
    throughput_mode  = "bursting"
    encrypted        = "true"
    tags = {
        Name = "DIF-EFS"
    }
}

resource "aws_security_group" "DIF_INGRESS_EFS" {
  vpc_id = aws_vpc.RDSYS_VPC.id
  name   = "DIF_INGRESS_EFS"
  ingress {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
  }
  tags = {
    Name = "DIF-EFS"
  }
}

resource "aws_efs_mount_target" "DIF-EFS-MT" {
   file_system_id   = aws_efs_file_system.DIF_EFS.id
   subnet_id        = aws_subnet.DIF_PRIVATE_SUBNET.id
}
 
