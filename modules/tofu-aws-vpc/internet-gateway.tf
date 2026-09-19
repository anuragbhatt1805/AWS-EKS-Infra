resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route" "public_internet" {
  gateway_id     = aws_internet_gateway.this.id
  route_table_id = aws_route_table.public.id

  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id

  count = length(var.aws_availability_zones)
}