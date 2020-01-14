#-----------------------------------------------------------------------
#Solution for installing wordpress using HAProxy in Docker via Terraform
#-----------------------------------------------------------------------

provider "aws" {
  region = "eu-central-1"
}

/*instance 1*/
resource "aws_instance" "Server_Docker_HAProxy" {
    ami                    = "ami-0cc0a36f626a4fdf5" #Ubuntu Server 18.04 LTS
    instance_type          = "t2.micro"
    private_ip             = "172.31.32.100"
    key_name               = "key_for_terraform"
    vpc_security_group_ids = [aws_security_group.my_webserver.id]
    user_data              = file("https://raw.githubusercontent.com/anatoliykv/terraform_wordpress_mysql_haproxy/master/user_data_docker_haproxy.sh")
  tags = {
    Name = "Server_Docker_HAProxy Build by Terraform"
    Owner = "anatoliykv"
  }
}

resource "aws_instance" "Server_Docker_WP_SQL" {
    ami                    = "ami-0cc0a36f626a4fdf5" #Ubuntu Server 18.04 LTS
    instance_type          = "t2.micro"
    private_ip             = "172.31.32.101"
    key_name               = "key_for_terraform"
    vpc_security_group_ids = [aws_security_group.my_webserver.id]
    user_data =            = file("user_data.sh")
  tags = {
    Name = "Server_Docker_WP_SQL Build by Terraform"
    Owner = "anatoliykv"
  }
}

resource "aws_instance" "Server_Docker_WP_WP" {
    ami                    = "ami-0cc0a36f626a4fdf5" #Ubuntu Server 18.04 LTS
    instance_type          = "t2.micro"
    private_ip             = "172.31.32.102"
    key_name               = "key_for_terraform"
    vpc_security_group_ids = [aws_security_group.my_webserver.id]
    #user_data =            = file("user_data.sh")
  tags = {
    Name = "Server_Docker_WP_WP Build by Terraform"
    Owner = "anatoliykv"
  }
}

resource "aws_security_group" "my_webserver" {
  name        = "allow_web_ssh"
  description = "My Security group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Group Terraform"
    Owner = "anatoliykv"
  }
}
