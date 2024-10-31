# File orgInfra/modules/internet_gateway/main.tf

resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.vpc_name}-internet-gateway"
  }
}

output "igw_id" {
  value = aws_internet_gateway.this.id
}
