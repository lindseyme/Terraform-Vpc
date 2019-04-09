resource "aws_instance" "frontend-app" {
  ami             = "ami-0828d2b6406d5f485"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.frontend-security-sg.id}"]
  key_name        = "${aws_key_pair.mykeypair.key_name}"

  subnet_id = "${aws_subnet.frontend-pub.id}"

  tags = {
    Name = "frontend"
  }
}

resource "aws_instance" "frontend-app-backup" {
  ami             = "ami-0828d2b6406d5f485"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.frontend-security-sg.id}"]
  key_name        = "${aws_key_pair.mykeypair.key_name}"

  subnet_id = "${aws_subnet.frontend-backup-pub.id}"

  tags = {
    Name = "frontend-backup"
  }
}
