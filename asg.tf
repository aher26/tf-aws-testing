resource "aws_launch_configuration" "asg_config" {
  name                 = "ASG Configuration"
  image_id             = "ami-0c07e2aaed446d8df"
  instance_type        = "t2.medium"
  security_groups      = [aws_security_group.asg_sg.id]
  user_data            = file("user_data.sh")
  iam_instance_profile = aws_iam_instance_profile.asg_profile.name
}

resource "aws_lb_target_group" "asg_tg" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_autoscaling_group" "asg" {
  name                = "Auto Scaling Group"
  min_size            = 2
  max_size            = 5
  desired_capacity    = 2
  target_group_arns    = [aws_lb_target_group.asg_tg.arn]
  launch_configuration = aws_launch_configuration.asg_config.name
  vpc_zone_identifier  = [aws_subnet.private.id]

  tag {
    key                 = "Name"
    value               = "ASG Instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "cpu_policy" {
  name                   = "CPU Utilization Policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 45.0
  }
}