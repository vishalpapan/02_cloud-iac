provider "aws" {
    region = "us-east-1"
  
}

module "name" {
    source = "./modules/ec2-instance"
    ami_id_value = "ami-0360c520857e3138f"
    sg_id = "sg-0b698d1fe325d2c3a"
    instance_type = "t3a.micro"
    subnet_id_value = "subnet-0fde1949d61f6d9c9"
}