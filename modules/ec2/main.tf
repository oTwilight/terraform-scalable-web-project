resource "aws_launch_template" "lt" {
  name_prefix            = var.template_name
  image_id               = var.ami_id
  instance_type          = var.instance_type
  user_data              = local.user_data
  vpc_security_group_ids = [var.ec2_sg_id]
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.subnets
  launch_template {
    id      = aws_launch_template.lt.id
    version = var.template_version
  }

  target_group_arns = [var.target_group_arn]

  tag {
    key                 = local.key
    value               = local.value
    propagate_at_launch = true
  }

}