resource "aws_s3_bucket" "insecure-bucket" {
  bucket = "insecure-bucket"
}

resource "aws_s3_bucket_public_access_block" "insecure-bucket" {
   block_public_acls       = true
   block_public_policy     = true
   ignore_public_acls      = true
   restrict_public_buckets = true

   logging {
    target_bucket = aws_s3_bucket.insecure-bucket.id
    target_prefix = "log/"
  }

}

resource "aws_s3_bucket_versioning" "my_bucket_versioning" {
  bucket = aws_s3_bucket.insecure-bucket.id
   
    # MFA Delete must be set to Enabled
   versioning {
    enabled = true
    mfa_delete = true
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
