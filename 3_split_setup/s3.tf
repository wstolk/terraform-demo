# setup S3 bucket for storage of log data
resource "aws_s3_bucket" "terraform-demo-bucket" {
  bucket = "terraform-training-dip"

  tags = {
    Name = "Terraform Training Digital-Power",
    Environment = "dev"
  }
}

# log URL of S3 bucket
output "s3_bucket_id" {
  value = aws_s3_bucket.terraform-demo-bucket.id
}