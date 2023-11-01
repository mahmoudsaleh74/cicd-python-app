resource "aws_route_table" "publicsubnet_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.cidr_block
    gateway_id = var.igw_id
  }

  tags = {
    Name = var.rt_name
  }
}

resource "aws_route_table_association" "rt" {
  count = length(var.public_subnet_ids)
  subnet_id      = var.public_subnet_ids[0]
  route_table_id = aws_route_table.publicsubnet_rt.id
}