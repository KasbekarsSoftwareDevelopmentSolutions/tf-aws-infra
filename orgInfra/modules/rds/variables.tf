# File orgInfra/modules/rds/variables.tf

variable "rds_master_username" {
  description = "The master username for the RDS instance"
  type        = string
}

variable "rds_master_password" {
  description = "The master password for the RDS instance"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs where the RDS instance will be created"
  type        = list(string)
}

variable "db_engine" {
  description = "The database engine for the RDS instance"
  type        = string
  default     = "mysql" # Change to "mariadb" or "postgres" if needed
}

variable "rds_allocated_storage" {
  description = "Allocated storage for the RDS instance"
  type        = number
  default     = 20
}

variable "rds_storage_type" {
  description = "Storage type for the RDS instance"
  type        = string
  default     = "gp2"
}

variable "rds_instance_class" {
  description = "Instance class for the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "publicly_accessible" {
  description = "Whether the RDS instance is publicly accessible"
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Whether to deploy the RDS instance in multiple Availability Zones"
  type        = bool
  default     = false
}

variable "db_name" {
  description = "The name of the database to create"
  type        = string
  default     = "csye6225"
}

variable "db_instance_identifier" {
  description = "Identifier for the RDS instance"
  type        = string
  default     = "csye6225"
}

variable "rds_subnet_group_name" {
  description = "Name for the RDS subnet group"
  type        = string
  default     = "csye6225-rds-subnet-group"
}

variable "rds_param_group_name" {
  description = "Name for the RDS parameter group"
  type        = string
  default     = "csye6225-rds-parameter-group"
}

variable "rds_param_group_family" {
  description = "Family of the RDS parameter group"
  type        = string
  default     = "mysql8.0"
}

variable "db_param_name" {
  description = "The name of the database parameter"
  type        = string
  default     = "character_set_server"
}

variable "db_param_value" {
  description = "The value of the database parameter"
  type        = string
  default     = "utf8mb4"
}

variable "rds_security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs to assign to the RDS instance."
}
