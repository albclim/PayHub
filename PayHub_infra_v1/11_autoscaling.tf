
resource "tls_private_key" "app_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "REDSS-KEY"
  public_key = tls_private_key.app_private_key.public_key_openssh
}

#  ============================== AUTO SCALING PRI ==================================================================================

resource "aws_autoscaling_attachment" "PRI_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.PRI_asg.name
  alb_target_group_arn   = aws_lb_target_group.PRISO_TG.arn                   #  ==============CAMBIAR AL NUEVO TARGET GROUP==========

  #depends_on = [aws_autoscaling_group.app_asg]  =>use when dependency not visible to terraform
}

resource "aws_autoscaling_group" "PRI_asg" {
  name_prefix          = "PRI-ASG"
  launch_configuration = aws_launch_configuration.WIN16_launch_conf.id
#  availability_zones    = var.az_name_A                                          NOT USE IT, BETTER WITH vpc_zone_identifier
  vpc_zone_identifier = [
    aws_subnet.PRI1_PUBLIC_SUBNET.id,                                         # ================== CHECK IF IT WORKS ================
    aws_subnet.PRI2_PRIVATE_SUBNET.id
  ]
  min_size             = "1"
  max_size             = "4"
  health_check_type    = "EC2"
  lifecycle {
    create_before_destroy = true
  }

#  tags = {
#    "PRI-ASG"
#  }
}

# ========================================== AUTO SCALING ISO =======================================================================

resource "aws_autoscaling_attachment" "ISO_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.ISO_asg.name
  alb_target_group_arn   = aws_lb_target_group.PRISO_TG.arn    #  ========================CAMBIAR AL NUEVO TARGET GROUP===============

  #depends_on = [aws_autoscaling_group.app_asg]  =>use when dependency not visible to terraform
}

resource "aws_autoscaling_group" "ISO_asg" {
  name_prefix          = "ISO-ASG"
  launch_configuration = aws_launch_configuration.WIN16_launch_conf.id
#   availability_zones    = var.az_name_A                                          NOT USE IT, BETTER WITH vpc_zone_identifier
  vpc_zone_identifier = [
    aws_subnet.ISO1_PUBLIC_SUBNET.id,                                         # ================== CHECK IF IT WORKS ================
    aws_subnet.ISO2_PRIVATE_SUBNET.id
  ]
  min_size             = "1"
  max_size             = "4"
  health_check_type    = "EC2"
  lifecycle {
    create_before_destroy = true
  }

#  tags = {
#    "PRISO-ASG"
#  }
}

# ===================================== IMAGES ===============================================================

resource "aws_launch_configuration" "UBUNTU_launch_conf" {
  name_prefix                 = "UBUNTU-APP-LC"
  image_id                    = "ami-08c757228751c5335"
  instance_type               = var.instance_type
  user_data                   = data.template_file.ubuntu-config-template.rendered
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.app_instance_profile.name
  security_groups             = [aws_security_group.RDSYS_SG.id, aws_security_group.GATE_SG.id]   # =================== CAMBIAR CON NUEVO SEC GROUP===================
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
  instance_type               = var.instance_type
  user_data                   = data.template_file.windows-config-template.rendered
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.app_instance_profile.name
  security_groups             = [aws_security_group.RDSYS_SG.id, aws_security_group.GATE_SG.id] # =================== CAMBIAR CON NUEVO SEC GROUP===================
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





# ========================== EN CASO DE QUE FALLE PRISO_ASG_ATTACHMENT =================
/*
resource "aws_autoscaling_attachment" "PRISO_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.PRISO_asg.name
  alb_target_group_arn   = aws_lb_target_group.PRISO_TG.arn    #  ========================CAMBIAR AL NUEVO TARGET GROUP===============

  #depends_on = [aws_autoscaling_group.app_asg]  =>use when dependency not visible to terraform
}
resource "aws_autoscaling_attachment" "PRISO_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.PRISO_asg.name
  alb_target_group_arn   = aws_lb_target_group.PRISO_TG.arn    #  ========================CAMBIAR AL NUEVO TARGET GROUP===============

  #depends_on = [aws_autoscaling_group.app_asg]  =>use when dependency not visible to terraform
}
*/