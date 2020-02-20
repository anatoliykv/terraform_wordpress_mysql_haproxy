resource "aws_instance" "Server_Docker_HAProxy" {
    ami                    = var.ami_id #Ubuntu Server 18.04 LTS
    instance_type          = "t2.micro"
    # private_ip             = "172.31.32.100"
    key_name               = "key_for_terraform"
    vpc_security_group_ids = [aws_security_group.my_webserver.id]
    user_data              = file("user_data_docker_haproxy.sh")
  tags = {
    Name = "Server_Docker_HAProxy Build by Terraform"
    Owner = "anatoliykv"
  }
}

resource "aws_instance" "Server_Docker_WP_SQL" {
    ami                    = var.ami_id #Ubuntu Server 18.04 LTS
    instance_type          = "t2.micro"
    # private_ip             = "172.31.32.101"
    key_name               = "key_for_terraform"
    vpc_security_group_ids = [aws_security_group.my_webserver.id]
    user_data              = file("user_data_docker_wp_sql.sh")
  tags = {
    Name = "Server_Docker_WP_SQL Build by Terraform"
    Owner = "anatoliykv"
  }
}

resource "aws_instance" "Server_Docker_WP_WP" {
    ami                    = var.ami_id #Ubuntu Server 18.04 LTS
    instance_type          = "t2.micro"
    # private_ip             = "172.31.32.102"
    key_name               = "key_for_terraform" // use resource aws_key
    vpc_security_group_ids = [aws_security_group.my_webserver.id]
    user_data              = file("user_data_docker_wp_wp.sh")
  tags = {
    Name = "Server_Docker_WP_WP Build by Terraform"
    Owner = "anatoliykv"
  }
}
