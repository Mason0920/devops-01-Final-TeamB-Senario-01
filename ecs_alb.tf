resource "aws_lb" "project4_ecs_alb" {
  name               = "project4-ecs-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.final_project4_sg.id]
  subnets            = [aws_subnet.subnet_public1.id, aws_subnet.subnet_public2.id]

  tags = {
    Environment = "final_project4-ecs-alb"
  }
}

resource "aws_lb_target_group" "ecs-alb-tg" {
  name       = "ecs-alb-tg"
  port              = 80
  protocol          = "HTTP"
  protocol_version  = "HTTP1"
  target_type       = "ip"
  vpc_id            = aws_vpc.project4_vpc.id

   health_check {
    enabled         = true
    healthy_threshold = 2
    unhealthy_threshold = 2
    interval = 30
    matcher = 200
    path = "/health"
    port = "traffic-port"
    protocol = "HTTP"
    timeout = 5
  }
}

// 이것의 역할을 잘 모르겠음
# resource "aws_lb_target_group_attachment" "attach-target" {
#   target_group_arn = aws_lb_target_group.ecs-alb-tg.arn
#   target_id        = aws_lb_target_group.ecs-alb-tg.
#   port             = 80
# }


resource "aws_lb_listener" "ecs-alb-listener" {
  load_balancer_arn = aws_lb.project4_ecs_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs-alb-tg.arn
}

}