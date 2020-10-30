# initialize AWS provider
provider "aws" {
    version = "~> 2.63"
    region = var.aws_region
}