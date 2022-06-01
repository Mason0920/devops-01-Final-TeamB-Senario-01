resource "aws_route_table" "project-rtb-private1-ap-northeast-2a" {
    vpc_id     = aws_vpc.project4_vpc.id
    tags = {
        Name                      = "private1"
    }
}
 
resource "aws_route_table" "project-rtb-private2-ap-northeast-2b" {
    vpc_id     = aws_vpc.project4_vpc.id
    tags = {
       Name                      = "private2"
   }
}


resource "aws_route_table" "project-rtb-public" {
    vpc_id     = aws_vpc.project4_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.project_igw.id
    }
}

