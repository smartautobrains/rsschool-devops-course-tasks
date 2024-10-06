provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "company-terraform-state-${var.environment}-bucket"
    key            = "${var.environment}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-${var.environment}-table"
  }
}