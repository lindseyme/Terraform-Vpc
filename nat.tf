resource "aws_instance" "nat-app" {
  ami             = "ami-00d1f8201864cc10c"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.frontend-security-sg.id}"]
  key_name        = "${aws_key_pair.mykeypair.key_name}"

  subnet_id = "${aws_subnet.frontend-pub.id}"

  tags = {
    Name = "nat"
  }
}
