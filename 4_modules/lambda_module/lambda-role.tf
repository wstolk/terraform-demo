# Add Lambda function for pushing device ID's to the SQS queue
resource "aws_iam_role" "terraform-example-lambda-role" {
  name = "ml_train_predict_iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name = "ml_train_predict_lambda_iam_role"
    Environment = var.environment
  }
}

resource "aws_cloudwatch_log_group" "terraform-example-lambda-log-group" {
  name = "/aws/lambda/${aws_lambda_function.terraform-example-lambda-function.function_name}"
  retention_in_days = 1
}

resource "aws_iam_policy" "terraform-demo-policy-lambda" {
  name = "lambda_s3_dynamodb"
  path = "/"
  description = "IAM policy for logging from a lambda and interacting with DynamoDB and S3"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "s3:*"
      ],
      "Resource": "${var.s3_bucket.arn}/*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "dynamodb:BatchGetItem",
        "dynamodb:GetItem",
        "dynamodb:Query",
        "dynamodb:Scan",
        "dynamodb:BatchWriteItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem"
      ],
      "Resource": "${var.dynamodb_table.arn}",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role = aws_iam_role.terraform-example-lambda-role.name
  policy_arn = aws_iam_policy.terraform-demo-policy-lambda.arn
}

resource "aws_lambda_permission" "terraform-demo-execute-with-s3" {
  statement_id = "AllowExecutionFromS3"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.terraform-example-lambda-function.function_name
  principal = "s3.amazonaws.com"
  source_arn = var.s3_bucket.arn
}