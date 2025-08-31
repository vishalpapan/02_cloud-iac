provider "aws" {
    region = "us-east-1"
}

variable "ami" {
    description = "ami value"
}

variable "subnet_id" {
  description = "sunbnet id"
}

variable "security_group_id" {
  description = "security group"
}

variable "instance_type" {
  description = "instance type"
}

resource "aws_instance" "tf-demo-workspace" {
  instance_type = var.instance_type
  ami = var.ami
  subnet_id = var.subnet_id
  security_groups = [var.security_group_id]
}

