provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket         = "company-terraform-state-prod-bucket-1"
    key            = "prod/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-lock-prod-table"
  }
}
