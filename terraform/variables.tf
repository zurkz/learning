variable "aws_region" {
    description = "region for VPC"
    default = "us-east-1"
}

variable "vpc_cidr" {
    description = "cidr for the VPC"
    default = "10.0.0.0/16"
}

variable "private_subnet_cidr" {
    description = "private subnet cidr range"
    default = "10.0.1.0/24"
}

variable "public_subnet_cidr" {
    description = "public subnet cidr range"
    default = "10.0.2.0/24"
}

variable "ami_id" {
    description = "the ami for EC2 instances"
    # Amazon Linux 2
    default = "ami-009d6802948d06e52"
}
