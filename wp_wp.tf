#-----------------------------------------
#My terraform
#Build server with Docker, WP, SQL

provider "aws" {
  region = "eu-central-1"
}

/*коментарий*/
resource "aws_instance" "Docker_WP_SQL" {
    ami                    = "ami-0cc0a36f626a4fdf5" #Ubuntu
    instance_type          = "t2.micro"
    vpc_security_group_ids = ["aws_security_group.my_webserver.id"]
    key_name               = "key_for_terraform"
    aws_network_interfaces = ["aws_network_interface.IP_for_HAProxy.id"]
    aws_vpces              = ["aws_vpc.main.id"]
#    user_data              = file("user_data.sh")

  tags = {
    Name = "Keepalived build by Terraform"
    Owner = "anatoliykv"
  }
}

#Private IP for instance
resource "aws_network_interface" "IP_for_HAProxy" {
  subnet_id       = "aws_subnet.main.id"
  private_ips     = ["10.0.0.50"]
  security_groups = ["aws_security_group.my_webserver.id"]

  attachment {
    instance     = "aws_instance.Docker_WP_SQL.id"
    device_index = 1
  }
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "dedicated"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = "aws_vpc.main.id"
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "Main"
  }
}

resource "aws_security_group" "my_webserver" {
  name        = "allow_tls_ssh"
  description = "My Security group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]# add a CIDR block here
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]# add a CIDR block here
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]# add a CIDR block here
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WebServer Security Group Terraform"
    Owner = "anatoliykv Terraform"
  }
}
