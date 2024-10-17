resource "aws_instance" "my_ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id = var.subnet_id

  tags = {
    Name = var.instance_name
  }

  vpc_security_group_ids = var.security_group_ids

  key_name = var.key_pair_name
}
