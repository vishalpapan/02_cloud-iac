variable "cidr" {
    description = "cidr block to be created on the vpc"
}

variable "subnet-cidr" {
    description = "cidr block for the subnet of the vpc"
}

variable "subnet-az" {
    description = "availablity zone for the subnet"
  
}

variable "ec2-ami" {
    description = "ami to be launched on ec2 instance"
  
}

variable "instance_type" {
    description = "instance type to be deployed"
}
