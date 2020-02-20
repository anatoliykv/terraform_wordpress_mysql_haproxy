data "template_file" "init" {
  template = "${file("haproxy.cfg")}"

  vars = {
    wpwp = aws_instance.Server_Docker_WP_SQL.private_ip
    wpwp1 =
    wpwp2 =
  }
}
