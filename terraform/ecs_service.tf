resource "aws_ecs_service" "ecs_service" {
  name            = "ecs_service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.test.id
  desired_count   = 1
  launch_type     = "FARGATE"
  

  network_configuration {
    subnets         = [aws_subnet.subnet_public1.id, aws_subnet.subnet_public2.id, aws_subnet.subnet_private1.id, aws_subnet.subnet_private2.id]
    security_groups = [
      aws_security_group.final_project4_sg.id
    ]
    assign_public_ip = true
  }

  load_balancer {
       target_group_arn = aws_lb_target_group.reserv_api_server.arn
        container_name   = "test-container"
        container_port   = 3000
    }

  depends_on = [aws_lb_listener.alb-listener]
}


