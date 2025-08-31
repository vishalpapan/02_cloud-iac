terraform {
  backend "s3" {
    bucket = "tf-demo-s3-bucket-vpa"
    key = "terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    dynamodb_table = "terraform-lock"
  }
}