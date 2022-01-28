terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "my-tf-log-bucket"
  acl    = "log-delivery-write"
  tags = {
    yor_trace = "993fddd3-31d1-4a96-b0da-8802d04cf0a7"
  }
}
resource "aws_s3_bucket" "foo" {
  acl = "public-read-write"

  bucket = "foo_name"
  versioning {
    enabled = false
  }
  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }
  tags = {
    yor_trace = "ff6e3516-53b1-4622-9d59-ead7db6c55f8"
  }
}