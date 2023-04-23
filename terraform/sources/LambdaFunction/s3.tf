

data "aws_s3_bucket" "lovecraft-deployment-bucket" {
  bucket = var.deployment-bucket
}

data "aws_s3_object" "lovecraft-deployment-object" {
  bucket = var.deployment-bucket
  key    = var.deployment-object-name
}