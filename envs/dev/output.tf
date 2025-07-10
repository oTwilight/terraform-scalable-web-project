output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "public_subnets" {
  value = module.vpc.public_subnet_ids
}

output "asg_name" {
  value = module.ec2.asg_name
}