variable "bucket_name" {
  description = "The name of the S3 bucket to store the Terraform state file."
  type        = string
}

variable "state_lock" {
  description = "The name of the DynamoDB table to use for state locking."
  type        = string
}