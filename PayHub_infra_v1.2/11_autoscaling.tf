
resource "tls_private_key" "app_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "APP-KEY"
  public_key = tls_private_key.app_private_key.public_key_openssh
}

#  ============================== AUTO SCALING PRI ==================================================================================

resource "aws_autoscaling_attachment" "PRI_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.PRI_asg.name
  alb_target_group_arn   = aws_lb_target_group.PRI_TG.arn
  #depends_on = [aws_autoscaling_group.app_asg]  =>use when dependency not visible to terraform
}

resource "aws_autoscaling_group" "PRI_asg" {
  name_prefix          = "PRI-ASG"
  launch_configuration = aws_launch_configuration.WIN16_launch_conf.id
#  availability_zones    = var.az_name_A                                          NOT USE IT, BETTER WITH vpc_zone_identifier
  vpc_zone_identifier = [
    aws_subnet.PRI1_PRIVATE_SUBNET.id,
    aws_subnet.PRI2_PRIVATE_SUBNET.id
  ]
  min_size             = "1"
  max_size             = "4"
  health_check_type    = "EC2"
  lifecycle {
    create_before_destroy = true
  }
}

# ========================================== AUTO SCALING ISO =======================================================================

resource "aws_autoscaling_attachment" "ISO_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.ISO_asg.name
  alb_target_group_arn   = aws_lb_target_group.ISO_TG.arn
}

resource "aws_autoscaling_group" "ISO_asg" {
  name_prefix          = "ISO-ASG"
  launch_configuration = aws_launch_configuration.WIN16_launch_conf.id
  vpc_zone_identifier = [
    aws_subnet.ISO1_PRIVATE_SUBNET.id,
    aws_subnet.ISO2_PRIVATE_SUBNET.id
  ]
  min_size             = "1"
  max_size             = "4"
  health_check_type    = "EC2"
  lifecycle {
    create_before_destroy = true
  }
}

# ========================================== AUTO SCALING INST =======================================================================

resource "aws_autoscaling_attachment" "INST_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.INST_asg.name
  alb_target_group_arn   = aws_lb_target_group.INST_TG.arn
}

resource "aws_autoscaling_group" "INST_asg" {
  name_prefix          = "INST-ASG"
  launch_configuration = aws_launch_configuration.WIN16_launch_conf.id
  vpc_zone_identifier = [
    aws_subnet.INST1_PRIVATE_SUBNET.id,
    aws_subnet.INST2_PRIVATE_SUBNET.id
  ]
  min_size             = "1"
  max_size             = "4"
  health_check_type    = "EC2"
  lifecycle {
    create_before_destroy = true
  }
}
# ========================================== AUTO SCALING GPI =======================================================================

resource "aws_autoscaling_attachment" "GPI_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.GPI_asg.name
  alb_target_group_arn   = aws_lb_target_group.GPI_TG.arn
}

resource "aws_autoscaling_group" "GPI_asg" {
  name_prefix          = "GPI-ASG"
  launch_configuration = aws_launch_configuration.WIN16_launch_conf.id
  vpc_zone_identifier = [
    aws_subnet.GPI1_PRIVATE_SUBNET.id,
    aws_subnet.GPI2_PRIVATE_SUBNET.id
  ]
  min_size             = "1"
  max_size             = "4"
  health_check_type    = "EC2"
  lifecycle {
    create_before_destroy = true
  }
}




