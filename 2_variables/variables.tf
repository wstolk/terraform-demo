# setup 2_variables
variable "aws_region" {
  type = string
  default = "eu-west-1"
}

variable "environment" {
  type = string
  default = "development"
}