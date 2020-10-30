# initialize AWS provider
provider "aws" {
    version = "~> 2.63"
    region = "eu-west-1"
}

resource "aws_s3_bucket" "terraform-demo-dip" {
    bucket = "terraform-demo-dip"

    tags = {
        Name = "terraform demo dip"
        Environment = "dev"
    }
}
