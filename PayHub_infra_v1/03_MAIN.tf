provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "RDSYS_VPC" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
      "Name" = "RDSYS-VPC"
    }
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

terraform {
  required_version = ">= 0.12"
}

locals {
  name_prefix = var.env
  default_tags = {
    Environment = var.env
    Product     = var.product
  }
  asg_default_tags = [
    {
      key                 = "Name"
      value               = "RDSYS"
      propagate_at_launch = "true"
    },
    {
      key                 = "Environment"
      value               = var.env
      propagate_at_launch = "true"
    },
  ]
}
