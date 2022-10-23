terraform {

  required_version = ">=0.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
}

# Create a VPC (can be usefull in further)
#resource "aws_vpc" "example" {
#  cidr_block = "10.0.0.0/16"
#}
