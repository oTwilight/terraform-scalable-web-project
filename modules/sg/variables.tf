variable "vpc_id" {
  type = string
}
variable "zero_cidr" {
  type = string
}
variable "sg_name" {
  type = string
}
variable "rule_type" {
  description = "Type of SG: 'public' or 'internal'"
  type        = string
}

variable "alb_sg_id" {
  type = string
}

variable "network_settings" {
  description = "Network configuration for protocols and ports"
  type = object({
    protocol = map(string)
    port     = map(number)
  })
}


