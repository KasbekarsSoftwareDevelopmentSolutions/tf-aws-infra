# File orgInfra/modules/launch_template/main.tf

data "aws_secretsmanager_secret_version" "ec2_credentials" {
  secret_id = var.ec2_credentials_secret_arn
}

locals {
  ec2_credentials = jsondecode(data.aws_secretsmanager_secret_version.ec2_credentials.secret_string)
}
resource "aws_launch_template" "app_launch_template" {
  name          = var.launch_template_name
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name

  network_interfaces {
    security_groups             = var.security_group_ids
    associate_public_ip_address = true
  }

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  monitoring {
    enabled = true
  }

  user_data = base64encode(<<-EOF
  #!/bin/bash
  set -e

  # Update package list and install necessary tools
  sudo apt-get update -y
  sudo apt-get install -y jq
  sudo apt-get install -y unzip

  # Install AWS CLI (if not installed already)
  if ! command -v aws &> /dev/null; then
    echo "Installing AWS CLI..."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
  fi

  # Set AWS CLI credentials and profile
  export AWS_DEFAULT_REGION=us-east-2 
  aws configure set aws_access_key_id ${local.ec2_credentials["access_key"]}
  aws configure set aws_secret_access_key ${local.ec2_credentials["secret_key"]}
  aws configure set default.region ${var.aws_region}

  # Fetch secrets from AWS Secrets Manager
  EC2_CREDENTIALS=$(aws secretsmanager get-secret-value --secret-id ec2/credentials | jq -r .SecretString)
  RDS_CREDENTIALS=$(aws secretsmanager get-secret-value --secret-id rds/credentials | jq -r .SecretString)
  S3_BUCKET_NAME=$(aws secretsmanager get-secret-value --secret-id s3/bucket-name | jq -r .SecretString)

  # Parse credentials
  EC2_ACCESS_KEY=$(echo $EC2_CREDENTIALS | jq -r .access_key)
  EC2_SECRET_KEY=$(echo $EC2_CREDENTIALS | jq -r .secret_key)
  RDS_DB_NAME=$(echo $RDS_CREDENTIALS | jq -r .db_name)
  RDS_USERNAME=$(echo $RDS_CREDENTIALS | jq -r .username)
  RDS_PASSWORD=$(echo $RDS_CREDENTIALS | jq -r .password)

  # Create the connection_string.txt file
  echo "spring.datasource.url=jdbc:mysql://${var.rds_endpoint}/$RDS_DB_NAME" > /opt/connection_string.txt
  echo "spring.datasource.username=$RDS_USERNAME" >> /opt/connection_string.txt
  echo "spring.datasource.password=$RDS_PASSWORD" >> /opt/connection_string.txt
  echo "cloud.aws.s3.bucket-name=$S3_BUCKET_NAME" >> /opt/connection_string.txt
  echo "cloud.aws.credentials.access-key=$EC2_ACCESS_KEY" >> /opt/connection_string.txt
  echo "cloud.aws.credentials.secret-key=$EC2_SECRET_KEY" >> /opt/connection_string.txt

  # Remove ":3306" from the spring.datasource.url line in connection_string.txt
  sudo sed -i '/^spring.datasource.url/s/:3306//' /opt/connection_string.txt

  # Copy the connection_string.txt to the dir where application jar is.
  sudo cp /opt/connection_string.txt /opt/cloudNativeApplicationFolder

  # Stop the application service
  sudo systemctl stop cloud-native-app.service

  # Created .env file
  echo "SPRING_DATASOURCE_URL=$(grep spring.datasource.url /opt/cloudNativeApplicationFolder/connection_string.txt | cut -d '=' -f2)" | sudo tee /etc/cloud-native-app.env
  echo "SPRING_DATASOURCE_USERNAME=$(grep spring.datasource.username /opt/cloudNativeApplicationFolder/connection_string.txt | cut -d '=' -f2)" | sudo tee -a /etc/cloud-native-app.env
  echo "SPRING_DATASOURCE_PASSWORD=$(grep spring.datasource.password /opt/cloudNativeApplicationFolder/connection_string.txt | cut -d '=' -f2)" | sudo tee -a /etc/cloud-native-app.env
  echo "CLOUD_AWS_S3_BUCKET_NAME=$(grep cloud.aws.s3.bucket-name /opt/cloudNativeApplicationFolder/connection_string.txt | cut -d '=' -f2)" | sudo tee -a /etc/cloud-native-app.env
  echo "CLOUD_AWS_SNS_TOPIC_ARN=$(grep cloud.aws.sns.topic-arn /opt/cloudNativeApplicationFolder/connection_string.txt | cut -d '=' -f2)" | sudo tee -a /etc/cloud-native-app.env

  echo "CLOUD_AWS_CREDENTIALS_ACCESS_KEY=$(grep cloud.aws.credentials.access-key /opt/cloudNativeApplicationFolder/connection_string.txt | cut -d '=' -f2)" | sudo tee -a /etc/cloud-native-app.env
  echo "CLOUD_AWS_CREDENTIALS_SECRET_KEY=$(grep cloud.aws.credentials.secret-key /opt/cloudNativeApplicationFolder/connection_string.txt | cut -d '=' -f2)" | sudo tee -a /etc/cloud-native-app.env

  # Update the EnvironmentFile path in the service file
  sudo sed -i 's|EnvironmentFile=.*|EnvironmentFile=/etc/cloud-native-app.env|' /etc/systemd/system/cloud-native-app.service

  # Update the ExecStart line to use the environment variables from the .env file
  sudo sed -i 's|ExecStart=.*|ExecStart=/usr/bin/java -jar /opt/cloudNativeApplicationFolder/movieRetirvalWebApp-0.0.1-SNAPSHOT.jar --spring.datasource.url=\$${SPRING_DATASOURCE_URL} --spring.datasource.username=\$${SPRING_DATASOURCE_USERNAME} --spring.datasource.password=\$${SPRING_DATASOURCE_PASSWORD}|' /etc/systemd/system/cloud-native-app.service

  # Configure the CLoud Watch Agent
  sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/cloudwatch-config.json

  # Reload systemd to apply changes
  sudo systemctl daemon-reload

  # Enable the service to start on boot
  sudo systemctl enable cloud-native-app.service
  sudo systemctl enable amazon-cloudwatch-agent.service

  # Restart the application service
  sudo systemctl start amazon-cloudwatch-agent.service
  sudo systemctl start cloud-native-app.service

  
  EOF
  )
}
