variable "vpc_name" {
  type = string
}
variable "zero_cidr" {
  type = string
}
variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}
locals {
  az_to_cidr = zipmap(var.azs, var.public_subnet_cidrs)
}