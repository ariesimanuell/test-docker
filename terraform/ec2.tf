resource "aws_key_pair" "terraform_ec2_key" {
  key_name   = "testaries"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD2MQ4+fdSnSSR5NfwjIxygj5N6EH9GFMTuWlYJpgU3jjtIwa/YeOfVXJ6FqxwEuj6M4rHzLnRItbJ9uLuaM72JgQUsiFjRPF0RS0AZdJ5jqKxAhxlnxaYYhXMxWPtRuCCfYDQ5HxU0osqB+Z8gRgnUyEOQo0MUBYwe9+6OefnvSsa2cmYq43Rq+qnORjk1NSFz+ZSq09XTUdrT+iatK6Z1TvAY+AFDP4AEzld9rzPsJCOhxYB9mcHT+sL1GQfOZ0wi8owXJVK9lOYhA1mRSeUDmAyUpAVn44E8uJ2oX0troO5Qe/3N8wy6klk0/Y5yDp7mE1yHVvN6fw9KJMXJeSCP MacBook-Pro.local"
}

resource "aws_instance" "test1app" {
  ami                         = "ami-04763b3055de4860b" #ubuntu16
  instance_type               = "t2.medium"
  private_ip                  = "172.28.0.5"
  associate_public_ip_address = "true"
  subnet_id                   = aws_subnet.publictestA.id
  vpc_security_group_ids      = ["${aws_security_group.Test1.id}"]
  key_name                    = "testaries"
  tags = {
    Name = "Test1"
  }

  connection {
    type        = "ssh"
    host        = "aws_instance.test1app.public_ip"
    user        = "ubuntu"
    private_key = file("key/testaries.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/ubuntu/docker-needs",
      "mkdir /home/ubuntu/docker-needs/certs",
    ]
  }

  provisioner "file" {
    source      = "../install-docker.sh"
    destination = "/home/ubuntu"
  }
  provisioner "file" {
    source      = "../nginx.conf"
    destination = "/home/ubuntu/docker-needs"
  }
  provisioner "file" {
    source      = "../Dockerfile-nginx"
    destination = "/home/ubuntu/docker-needs"
  }
  provisioner "file" {
    source      = "../docker-compose-nginx"
    destination = "/home/ubuntu/docker-needs"
  }
  provisioner "file" {
    source      = "../certs/test.crt"
    destination = "/home/ubuntu/docker-needs/certs"
  }
  provisioner "file" {
    source      = "../certs/test.key"
    destination = "/home/ubuntu/docker-needs/certs"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/install-docker.sh",
      "/bin/sh -c /home/ubuntu/install-docker.sh",
    ]
  }
}

resource "aws_instance" "test2app" {
  ami                         = "ami-04763b3055de4860b" #ubuntu16
  instance_type               = "t2.medium"
  private_ip                  = "172.28.0.6"
  associate_public_ip_address = "true"
  subnet_id                   = aws_subnet.publictestA.id
  vpc_security_group_ids      = ["${aws_security_group.Test2.id}"]
  key_name                    = "testaries"
  tags = {
    Name = "Test2"
  }
  connection {
    type        = "ssh"
    host        = "aws_instance.test2app.public_ip"
    user        = "ubuntu"
    private_key = file("key/testaries.pem")

  }

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/ubuntu/docker-needs",
    ]
  }
  provisioner "file" {
    source      = "../install-docker.sh"
    destination = "/home/ubuntu"
  }
  provisioner "file" {
    source      = "../elasticsearch.yml"
    destination = "/home/ubuntu/docker-needs"
  }
  provisioner "file" {
    source      = "../Dockerfile-elastic"
    destination = "/home/ubuntu/docker-needs"
  }
  provisioner "file" {
    source      = "../docker-compose-elastic"
    destination = "/home/ubuntu/docker-needs"
  }
  provisioner "file" {
    source      = "../docker-entrypoint.sh"
    destination = "/home/ubuntu/docker-needs"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/install-docker.sh",
      "/bin/sh -c /home/ubuntu/install-docker.sh",
    ]
  }

}
