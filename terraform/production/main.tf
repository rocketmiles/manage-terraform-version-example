provider "aws" {
  version = "~> 1.0"
}
# Create a VPC
resource "aws_vpc" "production" {
  cidr_block = "10.1.0.0/16"
}
