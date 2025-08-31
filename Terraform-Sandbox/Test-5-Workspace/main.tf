provider "aws" {
  region = "us-east-1"
}


variable "instance_type" {
  description = "instance type"
  type = map(string)

  default = {
    dev  = "t3a.nano"
    test = "t3a.micro"
    prod = "t3a.large"  
  }
 }

 module "modules" {
    source = "./modules"
    instance_type = lookup(var.instance_type,terraform.workspace,"t3a.micro") 
    /*lookup(inputMap dynamic, key string, …default dynamic) dynamic
    lookup retrieves the value of a single element from a map, given its key. 
    If the given key does not exist, the given default value is returned instead.*/
    subnet_id = var.subnet_id
    ami = var.ami
    security_group_id= var.security_group_id
 }