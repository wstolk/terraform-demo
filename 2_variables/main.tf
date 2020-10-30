# initialize AWS provider
provider "aws" {
    version = "~> 2.63"
    region = var.aws_region
}

resource "aws_s3_bucket" "terraform-demo-dip" {
    bucket = "terraform-demo-dip"

    tags = {
        Name = "terraform demo dip"
        Environment = var.environment
    }
}