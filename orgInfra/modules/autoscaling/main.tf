# File orgInfra/modules/autoscaling/main.tf

resource "aws_autoscaling_group" "app_asg" {
  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.subnet_ids

  target_group_arns = var.target_group_arns

  tag {
    key                 = "Name"
    value               = var.instance_name
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }
}

# resource "aws_autoscaling_policy" "scale_up" {
#   name                   = "scale-up-policy"
#   policy_type            = "TargetTrackingScaling"
#   autoscaling_group_name = aws_autoscaling_group.app_asg.name

#   target_tracking_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ASGAverageCPUUtilization"
#     }
#     target_value = var.upscale_cpu_utilization_percent
#   }
# }


# resource "aws_autoscaling_policy" "scale_down" {
#   name                   = "scale-down-policy"
#   policy_type            = "TargetTrackingScaling"
#   autoscaling_group_name = aws_autoscaling_group.app_asg.name

#   target_tracking_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ASGAverageCPUUtilization"
#     }
#     target_value = var.downscale_cpu_utilization_percent
#   }
# }

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale-up-policy"
  policy_type            = "StepScaling"
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
  adjustment_type        = "ChangeInCapacity"

  step_adjustment {
    metric_interval_lower_bound = var.upscale_cpu_utilization_percent
    scaling_adjustment          = 1
  }
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale-down-policy"
  policy_type            = "StepScaling"
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
  adjustment_type        = "ChangeInCapacity"

  step_adjustment {
    metric_interval_upper_bound = var.downscale_cpu_utilization_percent
    scaling_adjustment          = -1
  }

  step_adjustment {
    metric_interval_lower_bound = var.downscale_cpu_utilization_percent
    metric_interval_upper_bound = null
    scaling_adjustment          = -1
  }
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "high-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  period              = 30
  statistic           = "Average"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  threshold           = var.upscale_cpu_utilization_percent
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app_asg.name
  }
}

resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name          = "low-cpu-utilization"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  period              = 30
  statistic           = "Average"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  threshold           = var.downscale_cpu_utilization_percent
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app_asg.name
  }
}
