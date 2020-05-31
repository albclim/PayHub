resource "aws_lb" "PRI_alb" {
  name                       = "PRI-ALB"
  internal                   = true
  load_balancer_type         = "application"
  idle_timeout               = 600
  security_groups            = [aws_security_group.PRI_ALB_SG.id]
  subnets                    = [
    aws_subnet.PRI1_PUBLIC_SUBNET.id,
    aws_subnet.PRI2_PRIVATE_SUBNET.id
    ]
  
  enable_deletion_protection = false
  
  tags = {
      "Name" = "PRI-ALB"
    }
}

resource "aws_lb" "ISO_alb" {
  name                       = "ISO-ALB"
  internal                   = true
  load_balancer_type         = "application"
  idle_timeout               = 600
  security_groups            = [aws_security_group.ISO_ALB_SG.id]
  subnets                    = [
    aws_subnet.ISO1_PUBLIC_SUBNET.id,
    aws_subnet.ISO2_PRIVATE_SUBNET.id
    ]
  
  enable_deletion_protection = false
  
  tags = {
      "Name" = "ISO-ALB"
    }
}

# ============================= SECURITY GROUP ===========================================

resource "aws_security_group" "PRI_ALB_SG" {
  vpc_id = aws_vpc.RDSYS_VPC.id
  name   = "PRI_ALB_SG"
    ingress {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
      from_port = 80
      to_port   = 80
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
      from_port = 3389
      to_port   = 3389
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      cidr_blocks = ["88.22.118.201/32"]
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
      Name = "PRI-ALB"
    }
}

resource "aws_security_group" "ISO_ALB_SG" {
  vpc_id = aws_vpc.RDSYS_VPC.id
  name   = "ISO_ALB_SG"
    ingress {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
      from_port = 80
      to_port   = 80
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
      from_port = 3389
      to_port   = 3389
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
    }
    tags = {
      Name = "ISO-ALB"
    }
}

resource "aws_lb_target_group" "PRI_TG" {
  name        = "PRI-LB-TG"
  port        = "80"
  protocol    = "HTTP"
  vpc_id      = aws_vpc.RDSYS_VPC.id
  target_type = "instance"
  tags = {
      "Name" = "PRI-LB-TG"
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [name]
  }

  health_check {
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    matcher             = "200"
  }
}

resource "aws_lb_target_group" "ISO_TG" {
  name        = "ISO-LB-TG"
  port        = "80"
  protocol    = "HTTP"
  vpc_id      = aws_vpc.RDSYS_VPC.id
  target_type = "instance"
  tags = {
      "Name" = "ISO-LB-TG"
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [name]
  }

  health_check {
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    matcher             = "200"
  }
}

resource "aws_lb_listener" "PRI_http_listener" {
  load_balancer_arn = aws_lb.PRI_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.PRI_TG.arn
  }
}


resource "aws_lb_listener" "ISO_http_listener" {
  load_balancer_arn = aws_lb.ISO_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ISO_TG.arn
  }
}


