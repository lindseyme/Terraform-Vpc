resource "aws_vpc" "checkpoint-vpc" {
  cidr_block           = "10.18.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags {
    Name = "checkpoint-vpc"
  }
}

# creating a subnet for the frontend 
resource "aws_subnet" "frontend-pub" {
  vpc_id                  = "${aws_vpc.checkpoint-vpc.id}"
  cidr_block              = "10.18.1.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = "true"

  tags {
    Name = "frontend-pub"
  }
}

resource "aws_subnet" "frontend-backup-pub" {
  vpc_id                  = "${aws_vpc.checkpoint-vpc.id}"
  cidr_block              = "10.18.3.0/24"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = "true"

  tags {
    Name = "frontend-backup-pub"
  }
}

resource "aws_subnet" "backend-pub" {
  vpc_id                  = "${aws_vpc.checkpoint-vpc.id}"
  cidr_block              = "10.18.2.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = "false"

  tags {
    Name = "backend-pub"
  }
}


# creating an internet gateway
resource "aws_internet_gateway" "checkpoint-igw" {
  vpc_id = "${aws_vpc.checkpoint-vpc.id}"

  tags {
    Name = "checkpoint-igw"
  }
}


# creating route-tables
resource "aws_route_table" "checkpoint-rtb" {
  vpc_id = "${aws_vpc.checkpoint-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.checkpoint-igw.id}"
  }

  tags {
    Name = "checkpoint-rtb"
  }
}

resource "aws_route_table" "private-rtb" {
  vpc_id = "${aws_vpc.checkpoint-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.nat-app.id}"
  }

  tags {
    Name = "private-rtb"
  }
}

# subnet routetable associations with public subnets
resource "aws_route_table_association" "frontend-pub-assoc" {
  subnet_id      = "${aws_subnet.frontend-pub.id}"
  route_table_id = "${aws_route_table.checkpoint-rtb.id}"
}

resource "aws_route_table_association" "backend-pub-assoc" {
  subnet_id      = "${aws_subnet.backend-pub.id}"
  route_table_id = "${aws_route_table.private-rtb.id}"
}


