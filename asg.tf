resource "aws_autoscaling_group" "reserv_api_server" {

  name = "reservation-server-auto-group"

  vpc_zone_identifier = [aws_subnet.subnet_public1.id, aws_subnet.subnet_public2.id]

  target_group_arns = [aws_lb_target_group.reserv_api_server.arn]

  health_check_type         = "EC2"
  health_check_grace_period = 300

  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 3

  launch_template {
    id      = aws_launch_template.init_template.id
    version = "$Latest"
  }
  
  lifecycle { 
    create_before_destroy = true 
  }

  tag {
    key   = "Name"
    value = "reservation-api-server"
    propagate_at_launch = true
  }

  enabled_metrics = [
    "GroupAndWarmPoolDesiredCapacity",
    "GroupAndWarmPoolTotalCapacity",
    "GroupInServiceCapacity",
    "GroupPendingCapacity",
    "GroupPendingInstances",
    "GroupStandbyCapacity",
    "GroupStandbyInstances",
    "GroupTerminatingCapacity",
    "GroupTerminatingInstances",
    "GroupTotalCapacity",
    "WarmPoolDesiredCapacity",
    "WarmPoolMinSize",
    "WarmPoolPendingCapacity",
    "WarmPoolTerminatingCapacity",
    "WarmPoolTotalCapacity",
    "WarmPoolWarmedCapacity",
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
  metrics_granularity = "1Minute"

}

resource "aws_cloudwatch_metric_alarm" "scale-in" {
  alarm_name          = "terraform-Scale-in"
  comparison_operator = "LessThanOrEqualToThreshold"
  datapoints_to_alarm = 1
  evaluation_periods  = 1
  extended_statistic  = "p95"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  threshold           = 40
  treat_missing_data  = "ignore"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.reserv_api_server.name
  }

  alarm_description = "Autoscling EC2 CPU Scale-in <= 40% (p95)"
  actions_enabled   = true
  alarm_actions     = [
    aws_autoscaling_policy.scale-in.arn
    #sns 추가할것
  ]
}

resource "aws_cloudwatch_metric_alarm" "scale-out" {
  alarm_name          = "terraform-Scale-out"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  datapoints_to_alarm = 1
  evaluation_periods  = 1
  extended_statistic  = "p95"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  threshold           = 50
  treat_missing_data  = "missing"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.reserv_api_server.name
  }

  alarm_description = "Autoscling EC2 CPU Scale-out >= 50% (p95)"
  actions_enabled   = true
  alarm_actions     = [
    aws_autoscaling_policy.scale-out.arn
    #sns 추가할것
  ]
}

resource "aws_autoscaling_policy" "scale-in" {
  name                   = "Scale-in-policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.reserv_api_server.name
}

resource "aws_autoscaling_policy" "scale-out" {
  name                   = "Scale-out-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.reserv_api_server.name
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.reserv_api_server.id
  lb_target_group_arn = aws_lb_target_group.project4_tg.arn
}

resource "aws_key_pair" "peach" {
  key_name   = "peach.pem"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQChFTy2U9QG2BUQbgNRrFFmQzUr9DdXIdr/1W8sHzNWA0XbrKV6XZbb7sUg8bX5aZyqiAJTfxipZWpEv88BX5j7kwVfpHbq4yTB1DktAVcAc1cC8HeFJZfEjg4QqorsaZBXwy0zdqXE3LDuMtlwCe3twx+D+/8Vw5ZUxwkFisWm755HiRMyWe0B+4bRw9WpH0wMu7qJ/b/D8ow5RKArX4HGC4YaG/L/ct2uNrl+58H30Pufm/8X0RBG9rTHq5AhgSVf4fzDxr+JWyrc1KIz3AgjwEH5TtyDWBpNIhWUfRhGjBp26AAzvgLP4w9iWB5fYmVifoSqlCVFtxeMaoODJI7J peach"
}
