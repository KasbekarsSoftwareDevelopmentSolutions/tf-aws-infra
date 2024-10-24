resource "aws_instance" "my_ec2_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_pair_name
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = var.instance_name
  }

  # Auto-start application using SystemD via user_data
  user_data = <<-EOF
  #!/bin/bash
  set -e

  # Update package list
  sudo apt-get update -y

  # Create the connection_string.txt file
  echo "spring.datasource.url=mysql://${var.rds_master_username}:${var.rds_master_password}@${var.rds_endpoint}:${var.rds_port}/${var.db_name}" > /opt/connection_string.txt
  echo "spring.datasource.username=${var.rds_master_username}" >> /opt/connection_string.txt
  echo "spring.datasource.password=${var.rds_master_password}" >> /opt/connection_string.txt

  # Copy the connection_string.txt to the dir where application jar is.
  sudo cp /opt/connection_string.txt /opt/cloudNativeApplicationFolder

  # Stop the application service
  sudo systemctl stop cloud-native-app.service

  # Update the service file to use the connection string
  sudo sed -i 's|ExecStart=.*|ExecStart=/usr/bin/java -jar /opt/cloudNativeApplicationFolder/movieRetirvalWebApp-0.0.1-SNAPSHOT.jar --spring.datasource.url=$(grep spring.datasource.url /opt/cloudNativeApplicationFolder/connection_string.txt | cut -d "=" -f2) --spring.datasource.username=$(grep spring.datasource.username /opt/cloudNativeApplicationFolder/connection_string.txt | cut -d "=" -f2) --spring.datasource.password=$(grep spring.datasource.password /opt/cloudNativeApplicationFolder/connection_string.txt | cut -d "=" -f2)|' /etc/systemd/system/cloud-native-app.service

  # Reload systemd to apply changes
  sudo systemctl daemon-reload

  # Restart the application service
  sudo systemctl start cloud-native-app.service

  # Enable the service to start on boot
  sudo systemctl enable cloud-native-app.service

EOF

}
