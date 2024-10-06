resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "company-terraform-state-prod-bucket-1"

  tags = {
    Name        = "Prod Terraform State Bucket"
    Environment = "Prod"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "new_approach" {
  bucket = aws_s3_bucket.terraform_state_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-lock-prod-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Prod Terraform Lock Table"
    Environment = "Prod"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state_bucket.bucket

  versioning_configuration {
    status = "Enabled"
  }
}