module "vpc" {
  source              = "../../modules/vpc"
  vpc_name            = var.vpc_name
  zero_cidr           = var.zero_cidr
  vpc_cidr            = var.vpc_cidr
  azs                 = var.azs
  public_subnet_cidrs = var.public_subnet_cidrs
}

module "alb_sg" {
  source           = "../../modules/sg"
  sg_name          = var.alb_sg_name
  vpc_id           = module.vpc.vpc_id
  network_settings = var.network_settings
  zero_cidr        = var.zero_cidr
  alb_sg_id        = var.alb_sg_id
  rule_type        = "public"
}
module "ec2_sg" {
  source           = "../../modules/sg"
  sg_name          = var.sg_name
  vpc_id           = module.vpc.vpc_id
  network_settings = var.network_settings
  alb_sg_id        = module.alb_sg.security_group_id
  zero_cidr        = var.zero_cidr
  rule_type        = "internal"
}

module "alb" {
  source              = "../../modules/alb"
  vpc_id              = module.vpc.vpc_id
  subnets             = module.vpc.public_subnet_ids
  security_group_id   = module.alb_sg.security_group_id
  default_action_type = var.default_action_type
  tg_name             = var.tg_name
  lb_type             = var.lb_type
  lb_name             = var.lb_name
  network_settings    = var.network_settings

}

module "ec2" {
  source           = "../../modules/ec2"
  subnets          = module.vpc.public_subnet_ids
  ec2_sg_id        = module.ec2_sg.security_group_id
  target_group_arn = module.alb.target_group_arn
  instance_type    = var.instance_type
  ami_id           = var.ami_id
  template_name    = var.template_name
  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size
  template_version = var.template_version
}

