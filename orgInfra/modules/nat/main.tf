# File orgInfra/modules/nat/main.tf

resource "aws_eip" "vpc_eip" {
  domain = "vpc"
  tags = {
    Name = var.eip_name
  }
}

resource "aws_nat_gateway" "network_access_gateway" {
  allocation_id = aws_eip.vpc_eip.id
  subnet_id     = var.public_subnet_id
  tags = {
    Name = var.nat_gateway_name
  }
}

resource "aws_route" "private_nat_route" {
  route_table_id         = var.private_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.network_access_gateway.id
}
