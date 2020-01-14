#!/bin/bash
sudo apt update
sudo apt upgrade -y
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose 
sudo usermod -aG docker $USER
#newgrp docker && exit
rm get-docker.sh
#
wget https://raw.githubusercontent.com/anatoliykv/terraform_wordpress_mysql_haproxy/master/install_wp_sql.yml
sudo docker-compose -f install_wp_sql.yml up -d
