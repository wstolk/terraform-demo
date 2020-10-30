variable "environment" {
  type = string
}

variable "s3_bucket" {}

variable "dynamodb_table" {}

resource "aws_lambda_function" "terraform-example-lambda-function" {
  filename = "lambda_module/src/lambda-function.zip"
  function_name = "process_sensor_files"
  role = aws_iam_role.terraform-example-lambda-role.arn
  handler = "main.process_file"
  source_code_hash = filebase64sha256("lambda_module/src/lambda-function.zip")
  runtime = "python3.8"

  depends_on = [aws_iam_role.terraform-example-lambda-role]

  tags = {
    Name = "ml_train_predict_lambda_function"
    Environment = var.environment
  }
}

output "function_arn" {
  value = aws_lambda_function.terraform-example-lambda-function.arn
}