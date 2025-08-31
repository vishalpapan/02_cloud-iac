provider "aws" {
    region = "us-east-1"
  
}

resource "aws_instance" "test2" {
    instance_type = var.instance_type
    ami = var.ami_id_value
    subnet_id = var.subnet_id_value
    security_groups = [var.sg_id]
    key_name = "navopsqa-useast1-aws-key"
}
