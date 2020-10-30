module "lambda_function" {
  source = "./lambda_module"

  environment = var.environment
  s3_bucket = aws_s3_bucket.terraform-demo-bucket
  dynamodb_table = aws_dynamodb_table.terraform-demo-table
}