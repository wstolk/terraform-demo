resource "aws_dynamodb_table" "terraform-demo-table" {
  name = "SensorLogs"
  billing_mode = "PROVISIONED"
  read_capacity = 20
  write_capacity = 20
  hash_key = "SensorId"
  range_key = "Timestamp"

  attribute {
    name = "SensorId"
    type = "S"
  }

  attribute {
    name = "Timestamp"
    type = "S"
  }
}