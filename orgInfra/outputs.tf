# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# Subnet Outputs
output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.subnets.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.subnets.private_subnet_ids
}

# Internet Gateway Output
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = module.internet_gateway.igw_id
}

# Route Table Outputs
output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = module.route_tables.public_route_table_id
}

output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = module.route_tables.private_route_table_id
}

# Security Group Outputs
output "security_group_id" {
  description = "The ID of the created security group"
  value       = module.security_group.security_group_id
}

output "security_group_name" {
  description = "The name of the created security group"
  value       = module.security_group.security_group_name
}

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = module.ec2.instance_id
}

output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = module.ec2.public_ip
}

output "private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = module.ec2.private_ip
}

# RDS Outputs
output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = module.rds.rds_endpoint
}

output "rds_port" {
  description = "The port on which the RDS instance is listening"
  value       = module.rds.rds_port
}

output "db_name" {
  description = "The name of the database"
  value       = module.rds.db_name
}

output "rds_master_username" {
  description = "The master username for the RDS instance"
  value       = module.rds.rds_master_username
}
