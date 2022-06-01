resource "aws_lb" "project4_alb" {
  name               = "project4-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.final_project4_sg.id]
  subnets            = [aws_subnet.subnet_public1.id, aws_subnet.subnet_public2.id]

  tags = {
    Environment = "final_project4"
  }
}

resource "aws_lb_target_group" "project4_tg" {
  name     = "project4-tg"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = aws_vpc.project4_vpc.id
  health_check {
    enabled         = true
    healthy_threshold = 2
    unhealthy_threshold = 2
    interval = 30
    matcher = 200
    path = "/index.html"
    port = "traffic-port"
    protocol = "HTTP"
    timeout = 5
  }
}

resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.project4_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project4_tg.arn
  }
}

