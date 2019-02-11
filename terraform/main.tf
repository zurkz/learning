provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "/Users/daniel/.aws/credentials"
  profile                 = "terraform-user"
}

resource "aws_vpc" "tf-vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "shared"
  enable_dns_hostnames = true
  tags {
    Name = "Terraform-VPC"
  }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
}

resource "aws_subnet" "



margin: 0;
	position: absolute;
	top: 50%;
	left: 50%;
	margin-right: -50%;
	transform: translate(-50%, -50%);

resource "aws_security_group" "nat" {
    name = "tf-vpc-natsg"
    description = "security group to allow http and ssh from the private subnet to reach the internet"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr}"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "tf-vpc-natsg"
    }

    depends_on = ["aws_internet_gateway.gw"]
}

resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${var.public_subnet_cidr}"
  tags {
    Name = "tf-vpc-natgw"
  }
}



resource "aws_instance" "web" {
  ami = "ami-009d6802948d06e52"
  instance_type = "t2.micro"
  tags {
    Name = "websrv01-terraform"
    Location = "Virgina"
  }

