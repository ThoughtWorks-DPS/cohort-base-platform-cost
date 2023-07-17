resource "aws_s3_bucket" "athena_bucket" {
  provider = aws.cluster
  bucket        = var.athena_bucket_name
  force_destroy = true

  tags = merge(var.common_audit_tags, { Name : var.athena_bucket_name })
}

resource "aws_s3_bucket_server_side_encryption_configuration" "athena_bucket_encryption" {
  provider = aws.cluster
  bucket   = aws_s3_bucket.athena_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.athena.arn
      sse_algorithm     = "aws:kms"
    }

    bucket_key_enabled = true
  }
}
resource "aws_kms_key" "athena" {
  provider            = aws.cluster
  description         = "A KMS key used to encrypt athena log files stored in S3."
  enable_key_rotation = true
  #policy                  = data.aws_iam_policy_document.athena_kms_policy_doc.json
  tags = merge(var.common_audit_tags, { Name : var.athena_bucket_key_alias })
}

resource "aws_kms_alias" "athena" {
  provider      = aws.cluster
  name          = "alias/${var.athena_bucket_key_alias}"
  target_key_id = aws_kms_key.athena.key_id
}

resource "aws_athena_workgroup" "athena" {
  provider      = aws.cluster
  name          = var.athena_workgroup_name
  description   = "Workgroup used by Cost Tooling for CUR data"
  force_destroy = true

  configuration {
    enforce_workgroup_configuration = true

    result_configuration {
      output_location = "s3://${aws_s3_bucket.athena_bucket.bucket}/"

      encryption_configuration {
        encryption_option = "SSE_KMS"
        kms_key_arn       = aws_kms_key.athena.arn
      }
    }

    engine_version {
      selected_engine_version = var.athena_engine_version
    }
  }

  tags = merge(var.common_audit_tags, { Name : var.athena_bucket_name })

  depends_on = [
    module.this
  ]
}
