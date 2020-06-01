
# ============================================ TEMPLATES  =====================================================

data "template_file" "win16-1-config-template" {
  template = "${file("${path.module}/user-data/win16-1-config.ps1")}"
  vars = {
    INSTANCE_USERNAME = var.temp_windows_user_name
    INSTANCE_PASSWORD = var.temp_windows_user_pass
  }
}

data "template_file" "ubuntu-config-template" {
  template = "${file("${path.module}/user-data/ubuntu-config.sh")}"
  vars = {
    INSTANCE_USERNAME = var.temp_windows_user_name
    INSTANCE_PASSWORD = var.temp_windows_user_pass
  }
}

# ===================================== IMAGES ===============================================================

resource "aws_launch_configuration" "UBUNTU_launch_conf" {
  name_prefix                 = "UBUNTU-APP-LC"
  image_id                    = "ami-08c757228751c5335"
  instance_type               = var.instance_type_OL
  user_data                   = data.template_file.ubuntu-config-template.rendered
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.app_instance_profile.name
  security_groups             = [aws_security_group.PAYOL_SG.id, aws_security_group.GATE_OL_SG.id]
  key_name                    = aws_key_pair.generated_key.key_name
  root_block_device {
    volume_size           = "60"
    volume_type           = "gp2"
    delete_on_termination = true
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "WIN16_launch_conf" {
  name_prefix                 = "WIN2016-APP-LC"
  image_id                    = "ami-08f9a552e55285f32"
  instance_type               = var.instance_type_OL
  user_data                   = data.template_file.win16-1-config-template.rendered
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.app_instance_profile.name
  security_groups             = [aws_security_group.PAYOL_SG.id, aws_security_group.GATE_OL_SG.id]
  key_name                    = aws_key_pair.generated_key.key_name
  root_block_device {
    volume_size           = "60"
    volume_type           = "gp2"
    delete_on_termination = true
  }
  lifecycle {
    create_before_destroy = true
  }
}




