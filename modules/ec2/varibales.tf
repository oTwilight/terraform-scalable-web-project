variable "subnets" {
  type = list(string)
}

variable "ec2_sg_id" {
  description = "Security group ID of the ALB"
  type        = string
}

variable "target_group_arn" {
  type = string
}

variable "instance_type" {
  type = string
}
variable "ami_id" {
  type = string
}
variable "template_name" {
  type = string
}
variable "desired_capacity" {
  type = number
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}
variable "template_version" {
  type = string
}
locals {
  user_data = templatefile("${path.module}/user_data.sh", {})
}
locals {
  key   = "Name"
  value = "web_asg"
}
