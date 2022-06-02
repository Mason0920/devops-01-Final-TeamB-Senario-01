resource "aws_route_table_association" "project4-rtb-private1" {
    route_table_id = aws_route_table.project-rtb-private1-ap-northeast-2a.id
    subnet_id = aws_subnet.subnet_private1.id
}

resource "aws_route_table_association" "project4-rtb-private2" {
    route_table_id = aws_route_table.project-rtb-private2-ap-northeast-2b.id
    subnet_id = aws_subnet.subnet_private2.id
}

resource "aws_route_table_association" "project4-rtb-public1" {
    route_table_id = aws_route_table.project-rtb-public.id
    subnet_id = aws_subnet.subnet_public1.id
}

resource "aws_route_table_association" "project4-rtb-public2" {
    route_table_id = aws_route_table.project-rtb-public.id
    subnet_id = aws_subnet.subnet_public2.id
}

