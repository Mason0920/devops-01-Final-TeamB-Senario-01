resource "aws_ecs_cluster" "ecs_cluster_terraform" {
  name = "ecs_cluster_terraform"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}
