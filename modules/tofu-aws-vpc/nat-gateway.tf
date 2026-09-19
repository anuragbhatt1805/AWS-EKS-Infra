resource "aws_eip" "nat" {
  domain = "vpc"

  count = length(var.aws_availability_zones)
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  count = length(var.aws_availability_zones)

  depends_on = [
    aws_internet_gateway.this
  ]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  count = length(var.aws_availability_zones)
}

resource "aws_route" "private_nat" {
  nat_gateway_id = aws_nat_gateway.this[count.index].id
  route_table_id = aws_route_table.private[count.index].id

  destination_cidr_block = "0.0.0.0/0"

  count = length(var.aws_availability_zones)
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id

  count = length(var.aws_availability_zones)
}