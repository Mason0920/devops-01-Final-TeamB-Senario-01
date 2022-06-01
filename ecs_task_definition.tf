resource "aws_ecs_task_definition" "test" {
  family                   = "test-TD"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 1024
  execution_role_arn       = "arn:aws:iam::351954682436:role/ecsTaskExecutionRole"
  task_role_arn            = "arn:aws:iam::351954682436:role/ecsTaskExecutionRole"

  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "test-container",
    "image": "mcr.microsoft.com/windows/servercore/iis",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 3000,
        "hostPort": 3000
      }
    ]
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}


