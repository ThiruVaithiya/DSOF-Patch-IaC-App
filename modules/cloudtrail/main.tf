resource "aws_cloudtrail" "insecure-logging" {
  name           = "cloudtrail-logging"
  cloud_watch_logs_group_arn = "appLogs"
  s3_bucket_name = "my-cloudtrail-bucket"
  enable_logging = true
  enable_log_file_validation = true
  is_multi_region_trail = true
  kms_key_id = ${env.kmsid}
}
