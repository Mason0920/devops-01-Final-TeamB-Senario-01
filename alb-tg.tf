resource "aws_lb_target_group" "reserv_api_server" {
  name_prefix       = "web-tg"
  port              = 80
  protocol          = "HTTP"
  protocol_version  = "HTTP1"
  target_type       = "instance"
  vpc_id            = aws_vpc.project4_vpc.id

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