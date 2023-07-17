data "aws_eks_cluster" "eks" {
  name     = var.cluster_name
  provider = aws.cluster
}

data "aws_iam_openid_connect_provider" "eks" {
  url      = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer
  provider = aws.cluster
}

data "aws_iam_policy_document" "cost-tool-assume-role-policy" {
  statement {
    sid    = "CostToolAssumeRole"
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = [data.aws_iam_openid_connect_provider.eks.arn]
    }
    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "${substr(data.aws_iam_openid_connect_provider.eks.url, 0, 256)}:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "${substr(data.aws_iam_openid_connect_provider.eks.url, 0, 256)}:sub"
      values   = ["system:serviceaccount:cost_tool:${var.cost_tool_service_account}"]
    }
  }
}

data "aws_iam_policy_document" "cost-tool-role-policy" {
  statement {
    sid    = "AthenaAccess"
    effect = "Allow"
    actions = [
      "athena:*",
    ]
    resources = [
      "*"
    ]
  }

  statement {
    sid    = "ReadAccessToAthenaCurDataViaGlue"
    effect = "Allow"
    actions = [
      "glue:GetDatabase*",
      "glue:GetTable*",
      "glue:GetPartition*",
      "glue:GetUserDefinedFunction",
      "glue:BatchGetPartition"
    ]
    resources = [
      "arn:aws:glue:*:*:catalog",
      "arn:aws:glue:*:*:database/${var.cur_report_name}*}",
      "arn:aws:glue:*:*:table/${var.cur_report_name}*/*"
    ]
  }

  statement {
    sid    = "AthenaQueryResultsOutput"
    effect = "Allow"
    actions = [
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:ListMultipartUploadParts",
      "s3:AbortMultipartUpload",
      "s3:CreateBucket",
      "s3:PutObject",
    ]
    resources = [
      "arn:aws:s3:::aws-athena-query-results-*",
    ]
  }

  statement {
    sid    = "AllowUseOfS3Key"
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Descrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = [
      resource.aws_kms_key.athena.arn,
      module.this.s3_bucket_key_arn
    ]
  }

  statement {
    sid    = "S3ReadAccessToAwsBillingData"
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:List*"
    ]
    resources = [
      "arn:aws:s3:::${var.cur_bucket_name}",
      "arn:aws:s3:::${var.cur_bucket_name}/*"
    ]
  }
}
