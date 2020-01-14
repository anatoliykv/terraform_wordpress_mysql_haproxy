# Solution Wordpress, MySQL, HAProxy in Docker containers deployed by Terraform to AWS

For using this solution create Debian based Linux server and clone this repository:
https://github.com/anatoliykv/terraform_wordpress_mysql_haproxy.git

For installing Terraform use this script:
```
wget https://releases.hashicorp.com/terraform/0.12.19/terraform_0.12.19_linux_amd64.zip
sudo apt install unzip -y
unzip terraform_0.12.19_linux_amd64.zip
sudo mv terraform /bin
terraform -v
```
Then run this command:

```
terraform init
terraform plan (optional)
terraform apply
```
To destroy this solution use this command:
```
terraform destroy
```
