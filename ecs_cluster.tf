

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "ecs_cluster"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

