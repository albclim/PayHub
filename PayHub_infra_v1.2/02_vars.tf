variable "aws_region_OL" {
  description = "AWS Region"
  default     = ""
}

variable "aws_region_GPI" {
  description = "AWS Region GPI"
  default     = ""
}

variable "env_OL" {
  type    = string
  default = "PAYOL"
}

variable "product_OL" {
  type    = string
  default = ""
}

variable "dir_type" {
  type    = string
  default = "SimpleAD"
}

variable "az_name_A" {
  type    = list(string)
  default = [""]
}

variable "az_name_B" {
  type    = list(string)
  default = [""]
}

variable "az_name_C" {
  type    = list(string)
  default = [""]
}

variable "vpc_cidr_OL" {
  type = string
}

variable "instance_type_OL" {
  type = string
}

variable "subnet_cidr_PRI" {
  type    = list(string)
  default = [""]
}

variable "subnet_cidr_ISO" {
  type    = list(string)
  default = [""]
}

variable "subnet_cidr_INST" {
  type    = list(string)
  default = [""]
}

variable "subnet_cidr_GPI" {
  type    = list(string)
  default = [""]
}

variable "temp_windows_user_name" {
}

variable "temp_windows_user_pass" {
}

variable "domain_name_OL" {
}

variable "allocated_storage" {
}

variable "engine_name_OL" {
}

variable "engine_version" {
}

variable "db_instance_type_OL" {
}

variable "db_name_OL" {
}

variable "username" {
}

variable "password" {
}
