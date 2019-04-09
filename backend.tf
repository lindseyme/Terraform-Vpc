resource "aws_instance" "backend-app" {
  ami             = "ami-0c55b159cbfafe1f0"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.backend-security-sg.id}"]
  key_name        = "${aws_key_pair.mykeypair.key_name}"

  subnet_id = "${aws_subnet.backend-pub.id}"

  tags = {
    Name = "backend"
  }
}
