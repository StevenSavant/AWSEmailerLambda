resource "aws_s3_bucket" "s3-bucket" {
  bucket = var.s3_bucket_name
}