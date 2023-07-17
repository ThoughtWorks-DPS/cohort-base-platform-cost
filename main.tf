terraform {
  required_version = ">= 0.13, < 2.0"
}

module "this" {
  source = "./terraform-aws-cur/"

  providers = {
    aws = aws.cur
  }

  use_existing_s3_bucket  = false
  s3_bucket_name          = var.cur_bucket_name
  s3_bucket_prefix        = "cur"
  s3_use_existing_kms_key = false
  s3_kms_key_alias        = var.cur_bucket_key_alias

  report_name      = var.cur_report_name
  report_frequency = "HOURLY"
  report_additional_artifacts = [
    "ATHENA",
  ]

  report_format      = "Parquet"
  report_compression = "Parquet"
  report_versioning  = "OVERWRITE_REPORT"

  tags = merge(var.common_audit_tags, { Name : var.cur_report_name })
}
