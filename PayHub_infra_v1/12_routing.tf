

resource "aws_network_acl" "PUBL_NACL" {
  vpc_id     = aws_vpc.RDSYS_VPC.id
  subnet_ids = [
      aws_subnet.PRI1_PUBLIC_SUBNET.id,
      aws_subnet.ISO1_PUBLIC_SUBNET.id,
      aws_subnet.BACK_PUBLIC_SUBNET.id
    ]

  ingress {
    protocol   = "-1"
    rule_no    = 103
    action     = "allow"
    cidr_block = "88.22.118.201/32"
    from_port  = 0
    to_port    = 0
  }
    ingress {
        protocol   = "-1"
        rule_no    = 105
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
    }

  egress {
    protocol   = "-1"
    rule_no    = 106
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
      "Name" = "BACK-NACL"
    }
}

resource "aws_network_acl" "PRIV_NACL" {
  vpc_id     = aws_vpc.RDSYS_VPC.id
  subnet_ids = [
        aws_subnet.PRI2_PRIVATE_SUBNET.id,
        aws_subnet.ISO2_PRIVATE_SUBNET.id,
        aws_subnet.API_PRIVATE_SUBNET.id,
        aws_subnet.DIF_PRIVATE_SUBNET.id
    ]

    ingress {
        protocol   = "tcp"
        rule_no    = 200
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 23
        to_port    = 23
    }
    ingress {
        protocol   = "tcp"
        rule_no    = 201
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 80
        to_port    = 80
    }
    ingress {
        protocol   = "tcp"
        rule_no    = 202
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 3389
        to_port    = 3389
    }
    ingress {
        protocol   = "tcp"
        rule_no    = 203
        action     = "allow"
        cidr_block = "88.22.118.201/32"
        from_port  = 0
        to_port    = 0
    }
    ingress {
        protocol   = "-1"
        rule_no    = 204
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
    }

    egress {
        protocol   = "-1"
        rule_no    = 32005
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
    }

  tags = {
      "Name" = "BACK-NACL"
    }
}