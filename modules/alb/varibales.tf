variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}
variable "lb_type" {
  type = string
}
variable "lb_name" {
  type = string
}
variable "tg_name" {
  type = string
}
variable "default_action_type" {
  type = string
}
variable "network_settings" {
  description = "Network configuration for protocols and ports"
  type = object({
    protocol = map(string)
    port     = map(number)
  })
}