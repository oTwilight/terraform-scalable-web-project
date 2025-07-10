### ------ REGION ------ ###
variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

### ------ VPC ------ ###

variable "vpc_name" {
  type    = string
  default = "your_VPC_name"
}
variable "zero_cidr" {
  type    = string
  default = "0.0.0.0/0"
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}
variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
### ------ SG ------ ###

variable "sg_name" {
  type    = string
  default = "web-sg"
}
variable "alb_sg_name" {
  type    = string
  default = "alb-sg"
}
variable "alb_sg_id" {
  description = "SG ID of ALB, used for internal EC2 rules"
  type        = string
  default     = null

}
### ------ ALB ------ ###

variable "lb_type" {
  type    = string
  default = "application"
}
variable "lb_name" {
  type    = string
  default = "web-alb"
}
variable "tg_name" {
  type    = string
  default = "web-tg"
}
variable "default_action_type" {
  type    = string
  default = "forward"
}

### ------ Launch Template & EC2 ------ ###
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
variable "ami_id" {
  type    = string
  default = "ami-0faab6bdbac9486fb" # ubuntu  AMI Frankfurt(if you work in other region you should use your region base ami)
}
variable "template_name" {
  type    = string
  default = "web_template"
}
variable "desired_capacity" {
  type    = number
  default = 3
}

variable "min_size" {
  type    = number
  default = 2
}

variable "max_size" {
  type    = number
  default = 5
}
variable "template_version" {
  type    = string
  default = "$Latest"
}
### ------- S3 bucket variables ------- ###
# variable "s3_name" {
#     type = string 
#     default = "edo-terraform-state-bucket"
# }
# variable "key_value" {
#   type = string 
#   default = "scalable-web/dev/terraform.tfstate"
# }
### ------- map vars ------- ###

variable "network_settings" {
  description = "Network-related settings (protocols, ports, etc.)"
  type = object({
    protocol = map(string)
    port     = map(number)
  })
  default = {
    protocol = {
      http         = "HTTP"
      tcp          = "tcp"
      traffic_port = "traffic-port"
      all          = "-1"
    }
    port = {
      http  = 80
      https = 443
      ssh   = 22
    }
  }
}

