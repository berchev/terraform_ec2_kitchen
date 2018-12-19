provider "aws" {}

resource "aws_instance" "server" {
  ami                         = "ami-0e32ec5bc225539f5"
  instance_type               = "t2.micro"
  key_name                    = "gberchev_key_pair"
  associate_public_ip_address = "true"

  tags {
    Name = "ec2_server"
  }
}

output "server_name" {
  value = "${aws_instance.server.tags.Name}"
}

output "public_ip_address" {
  value = "${aws_instance.server.public_ip}"
}
