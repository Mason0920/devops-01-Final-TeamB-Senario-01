# 서브넷 그룹 생성
resource "aws_db_subnet_group" "final_project4_sg" {
    name        = "final_project4_sg"
    description = "Managed by Terraform"
    subnet_ids  = [aws_subnet.db-sn1.id, aws_subnet.db-sn2.id]
}

resource "aws_subnet" "db-sn1" {
    vpc_id                  = aws_vpc.project4_vpc.id
    cidr_block              = cidrsubnet("${aws_vpc.project4_vpc.cidr_block}", 4, 4) #"172.18.64.0/20"
    availability_zone       = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = false
}

resource "aws_subnet" "db-sn2" {
    vpc_id                  = aws_vpc.project4_vpc.id
    cidr_block              = cidrsubnet("${aws_vpc.project4_vpc.cidr_block}", 4, 5) #"172.18.80.0/20"
    availability_zone       = data.aws_availability_zones.available.names[1]
    map_public_ip_on_launch = false
}

# DB 인스턴스 생성
resource "aws_db_instance" "final_project_teamb" {
  db_name              = "final_project_teamb"
  engine               = "mysql"
  engine_version       = "8.0.28"
  multi_az             = true
  username             = "admin"
  password             = "asdf1234"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  db_subnet_group_name = "final_project4_sg"
  vpc_security_group_ids = [aws_security_group.final_project4_private_sg.id]

  skip_final_snapshot  = true

  # Optional and default
  max_allocated_storage = 0
  license_model         = "general-public-license"
  port                  = 3306
  publicly_accessible   = false
  storage_encrypted     = false
  storage_type          = "gp2"
  parameter_group_name  = "default.mysql8.0"
}
