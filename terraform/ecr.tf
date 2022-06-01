resource "aws_ecr_repository" "aws-ecr" {
  name = "$aws-ecr"
  tags = {
    Name        = "aws-ecr-terraform"
  }
}ecr.tf.txt