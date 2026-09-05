provider "aws" {
    region = "us-east-1" # Target region to deply resources
}

# create S3 bucket for remote state file
resource "aws_s3_bucket" "state" {
    bucket = var.bucket_name

    tags = {
    Name        = "Terraform State Bucket"
    Environment = "Bootstrap"
  }
}

# Enable versioning in a separate resource block
resource "aws_s3_bucket_versioning" "state_versioning" {
  bucket = aws_s3_bucket.state.id
  versioning_configuration {
    status = "Enabled"
  }
}

#DynamoDB table for state locking to prevent concurrent modifications
resource "aws_dynamodb_table" "terraform_state_lock" {
    name         = var.state_lock
    billing_mode = "PAY_PER_REQUEST"
    hash_key     = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }

    tags = {
        Name        = "Terraform State Lock Table"
        Environment = "Bootstrap"
    }
}      
