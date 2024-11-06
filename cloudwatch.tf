resource "aws_cloudwatch_metric_alarm" "cpu_utilization" {
  alarm_name          = "High CPU Utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "45"
  alarm_description   = "This alarm monitors EC2 instance CPU utilization"
  alarm_actions       = [aws_autoscaling_policy.cpu_policy.arn]
}

resource "aws_cloudwatch_metric_alarm" "memory_utilization" {
  alarm_name          = "High Memory Utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This alarm monitors EC2 instance memory utilization"
  alarm_actions       = [aws_autoscaling_policy.cpu_policy.arn]
}

resource "aws_cloudwatch_metric_alarm" "status_check_failed" {
  alarm_name          = "Instance Status Check Failed"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "This alarm monitors EC2 instance status check failures"
  alarm_actions       = [aws_autoscaling_policy.cpu_policy.arn]
}

resource "aws_cloudwatch_metric_alarm" "network_in" {
  alarm_name          = "High Network In"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "NetworkIn"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "1000000"
  alarm_description   = "This alarm monitors EC2 instance network in traffic"
  alarm_actions       = [aws_autoscaling_policy.cpu_policy.arn]
}

resource "aws_cloudwatch_metric_alarm" "network_out" {
  alarm_name          = "High Network Out"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "NetworkOut"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "1000000"
  alarm_description   = "This alarm monitors EC2 instance network out traffic"
  alarm_actions       = [aws_autoscaling_policy.cpu_policy.arn]
}