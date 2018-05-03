provider "aws" {
  version = "~> 1.0"
}
# Create a VPC
resource "aws_vpc" "qa" {
  cidr_block = "10.0.0.0/16"
}
