terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "name" {
    ami = "ami-00ca32bbc84273381"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["sg-0b698d1fe325d2c3a"]
    subnet_id = "subnet-0fde1949d61f6d9c9"
}

