resource "aws_s3_bucket" "remote_state" {
  bucket = "terraform-remote-state-2025"

  tags = {
    Name        = "Terraform Remote State"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.remote_state.id

  versioning_configuration {
    status = "Enabled"
  }
}
