
resource "aws_internet_gateway" "RDSYS_IGW" {     # ===== ESTA IGW ES PARA SUBNET PUBLICA DE PRI & ISO
  vpc_id = aws_vpc.RDSYS_VPC.id
  tags = {
      "Name" = "RDSYS-IGW"
    }
}


resource "aws_eip" "PRISO_EIP" {
}

resource "aws_nat_gateway" "PRI1_NAT" {
  subnet_id     = "aws_subnet.PRI1_PUBLIC_SUBNET.id"
#     aws_subnet.BACK_PRIVATE_SUBNET.id
  allocation_id = "aws_eip.PRISO_EIP.id"
#  depends_on    = "aws_internet_gateway.RDSYS_IGW."
  tags = {
      "Name" = "PRISO1-NGW"
    }
}

resource "aws_nat_gateway" "ISO1_NAT" {
  subnet_id     = "aws_subnet.ISO1_PUBLIC_SUBNET.id"
#     aws_subnet.BACK_PRIVATE_SUBNET.id
  allocation_id = "aws_eip.PRISO_EIP.id"
#  depends_on    = "aws_internet_gateway.RDSYS_IGW"
  tags = {
      "Name" = "ISO1-NGW"
    }
}

resource "aws_security_group" "RDSYS_SG" {
  vpc_id = aws_vpc.RDSYS_VPC.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [aws_vpc.RDSYS_VPC.cidr_block]
  }
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [aws_vpc.RDSYS_VPC.cidr_block]
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.RDSYS_VPC.cidr_block]
  }

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
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    tags = {
    Name = "DIF-EFS"
  }
}


resource "aws_security_group" "GATE_SG" {
  vpc_id = aws_vpc.RDSYS_VPC.id
  name   = "GATE-SG"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [aws_vpc.RDSYS_VPC.cidr_block]
  }
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [aws_vpc.RDSYS_VPC.cidr_block]
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.RDSYS_VPC.cidr_block]
  }

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
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
      "Name" = "GATE-SG"
    }
}
