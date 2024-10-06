resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "company-terraform-state-${var.environment}-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name        = "${var.environment} Terraform State Bucket"
    Environment = var.environment
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-lock-${var.environment}-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "${var.environment} Terraform Lock Table"
    Environment = var.environment
  }
}
