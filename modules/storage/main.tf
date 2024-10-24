resource "aws_s3_bucket" "insecure-bucket" {
  bucket = "insecure-bucket"
}

resource "aws_s3_bucket_public_access_block" "insecure-bucket" {
   block_public_acls       = true
   block_public_policy     = true
   ignore_public_acls      = true
   restrict_public_buckets = true
   versioning {
    enabled = true
    mfa_delete = true
  }
   logging {
    target_bucket = aws_s3_bucket.insecure-bucket.id
    target_prefix = "log/"
  }

}

resource "aws_s3_bucket_versioning" "my_bucket_versioning" {
  bucket = aws_s3_bucket.insecure-bucket.id

  # Enable versioning
  versioning_configuration {
    status = "Enabled"
    
    # MFA Delete must be set to Enabled
    mfa_delete {
      enabled = true
    }
  }
}

resource "aws_ebs_volume" "example" {
  availability_zone = "us-east-1a"
  size              = 20
  encrypted         = true
  tags = {
    Name = "insecure"
  }
}
