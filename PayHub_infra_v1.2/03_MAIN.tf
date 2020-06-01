
provider "aws" {
  region = var.aws_region_OL
}

resource "aws_vpc" "PAYOL_1_VPC" {
  cidr_block           = var.vpc_cidr_OL
  enable_dns_hostnames = true
  tags = {
      "Name" = "PAYOL-1-VPC"
    }
}

/*
resource "aws_vpc" "PAYOL_2_VPC" {
  cidr_block           = var.vpc_cidr_OL
  enable_dns_hostnames = true
  tags = {
      "Name" = "PAYOL-2-VPC"
    }
}
*/
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

terraform {
  required_version = ">= 0.12"
}

locals {
  name_prefix = var.env_OL
  default_tags = {
    environment = var.env_OL
    product_OL     = var.product_OL
  }
  asg_default_tags = [
    {
      key                 = "Name"
      value               = "PAYOL"
      propagate_at_launch = "true"
    },
    {
      key                 = "environment"
      value               = var.env_OL
      propagate_at_launch = "true"
    },
  ]
}

# terraform {
#   backend "s3" {
#     bucket = "PAYOL-TFSTATES"
#     key    = "infra-cm-instructors/terraform.tfstate"
#     region = "${var.aws_region}"
#   }
# }
