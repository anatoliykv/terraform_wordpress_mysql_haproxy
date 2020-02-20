#-----------------------------------------------------------------------
#Solution for installing wordpress using HAProxy in Docker via Terraform
#-----------------------------------------------------------------------

// Instance creation to module

/*instance 1*/

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
    from_port = 3306  // NO
    to_port   = 3306
    protocol  = "tcp"

    cidr_blocks = ["aws_instance.Server_Docker_WP_SQL.private_ip/32",
      "/32",
    ] // only WP can connect to DB
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Security Group Terraform"
    Owner = "anatoliykv"
  }
}
