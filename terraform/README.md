# Diving into Terraform

#### install terraform, create directory for terraform and create 


main.tf
```
provider "aws" {
  region                  = "us-west-1"
  shared_credentials_file = "/Users/daniel/.aws/credentials"
  profile                 = "terraform-user"
}

resource "aws_instance" "web" {
  ami = "ami-009d6802948d06e52"
  instance_type = "t2.micro"
  tags {
    Name = "websrv01-terraform"
  }
```