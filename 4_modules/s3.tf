# setup S3 bucket for storage of new models
resource "aws_s3_bucket" "terraform-demo-bucket" {
  bucket = "terraform-training-dip"

  tags = {
    Name = "Terraform Training Digital-Power",
    Environment = var.environment
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.terraform-demo-bucket.id

  lambda_function {
    lambda_function_arn = module.lambda_function.function_arn
    events = ["s3:ObjectCreated:*"]
  }

  depends_on = [
    module.lambda_function,
    aws_s3_bucket.terraform-demo-bucket
  ]
}

# log URL of S3 bucket
output "s3_bucket_id" {
  value = aws_s3_bucket.terraform-demo-bucket.id
}