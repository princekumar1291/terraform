terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.5.0"
    }
  }
  backend "s3" {
    bucket = "terraform-remote-state-2025"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-locks-2025"
  }
}


