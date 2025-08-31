provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "tf-demo-s3" {
    bucket = "tf-demo-s3-bucket-vpa"
}

resource "aws_dynamodb_table" "tf-dynamodb-table" {
    name           = "terraform-lock"
  billing_mode   = "PAY_PER_REQUEST"
    hash_key         = "LockID"

    attribute {
    name = "LockID"
    type = "S"
  }
}