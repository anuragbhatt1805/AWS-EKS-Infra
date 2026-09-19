data "aws_region" "current" {}

resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.this.id

  cidr_block        = var.public_subnet_cidr_blocks[count.index]
  availability_zone = var.aws_availability_zones[count.index]

  map_public_ip_on_launch = true
  count                   = length(var.aws_availability_zones)
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.this.id

  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = var.aws_availability_zones[count.index]

  map_public_ip_on_launch = false
  count                   = length(var.aws_availability_zones)
}