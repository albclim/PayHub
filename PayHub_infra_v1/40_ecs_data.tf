
# ============================================ TEMPLATES  =====================================================

data "template_file" "windows-config-template" {
  template = "${file("${path.module}/user-data/iis-config.ps1")}"

  vars = {
    INSTANCE_USERNAME = var.temp_windows_user_name
    INSTANCE_PASSWORD = var.temp_windows_user_pass
  }
}

data "template_file" "win16-config-template" {
  template = "${file("${path.module}/user-data/win16-config.ps1")}"

  vars = {
    INSTANCE_USERNAME = var.temp_windows_user_name
    INSTANCE_PASSWORD = var.temp_windows_user_pass
  }
}

data "template_file" "jumpbox-config-template" {
  template = "${file("${path.module}/user-data/win16-config.ps1")}"

  vars = {
    INSTANCE_USERNAME = var.temp_windows_user_name
    INSTANCE_PASSWORD = var.temp_windows_user_pass
  }
}


# ============================================   A M I   =====================================================
/*
data "aws_ami" "windows2016" {
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2016-English-Full-HyperV-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["801119661308"] # amazon
}

"ami-08f9a552e55285f32"

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu-bionic-18.04-amd64-server-*"]
  }
}

"ami-08c757228751c5335"

*/
