resource "aws_key_pair" "mykeypair" {
  key_name   = "AwsKey"
  public_key = "${file("${var.public_key}")}"
}
