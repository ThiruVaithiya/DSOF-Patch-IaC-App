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

# Create a bucket to store logs
resource "aws_s3_bucket" "my_log_bucket" {
  bucket = "my-log-bucket"
}

# Create the main S3 bucket with logging enabled
resource "aws_s3_bucket" "my_bucket" {
  bucket = aws_s3_bucket.insecure-bucket.id

  # Enable logging
  logging {
    target_bucket = aws_s3_bucket.my_log_bucket.id  # Bucket where logs will be stored
    target_prefix = "log/"  # Prefix for the log files
  }

  # Enable versioning
  versioning {
    enabled = true
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
