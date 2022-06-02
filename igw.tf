resource "aws_internet_gateway" "project_igw" {
    vpc_id = aws_vpc.project4_vpc.id

}

