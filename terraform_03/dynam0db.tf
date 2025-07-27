resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks-2025"                # Name of the table
  billing_mode = "PAY_PER_REQUEST"               # No need to manage read/write capacity

  hash_key     = "LockID"                         # Primary key attribute

  attribute {
    name = "LockID"
    type = "S"                                    # 'S' means String type
  }

  tags = {
    Name        = "Terraform Lock Table"
    Environment = "dev"
  }
}
