variable "account_id" {
  type      = string
  sensitive = true
}

variable "assume_role" {
  type      = string
  sensitive = true
}

variable "cluster_region" {
  description = "Region the EKS cluster is deployed to for this context"
  type        = string
  default     = "us-east-2"
}

variable "cur_report_name" {
  description = "Name of the CUR report for this account"
  type        = string
}

variable "cur_bucket_name" {
  description = "Name of the S3 bucket this report will be stored in"
  type        = string
}

variable "cur_region" {
  description = "Region to create the CUR in. NOTE: only us-east-1 is supported at this time"
  type        = string
  default     = "us-east-1"
}

variable "athena_bucket_name" {
  description = "Name of the bucket used to store Athena Query results."
  type        = string
  validation {
    condition     = can(regex("^aws-athena-query-results-*", var.athena_bucket_name))
    error_message = "The athena query results bucket name must begin with 'aws-athena-query-results-'"
  }
}

variable "athena_workgroup_name" {
  description = "Name of the Athena workgroup used for cost queries"
  type        = string
}

variable "athena_engine_version" {
  description = "The engine version the cost workgroup will use"
  type        = string
  default     = "Athena engine version 2"
}

variable "cur_bucket_key_alias" {
  description = "KMS Key used to encrypt the S3 data"
  type        = string
}

variable "athena_bucket_key_alias" {
  description = "KMS Key used to encrypt athena query results"
  type        = string
}

variable "common_audit_tags" {
  description = "Tags to be attached to all resources created"
  type = object({
    CreatedOn   = string,
    CreatedBy   = string,
    Project     = string,
    Support     = string,
    Capability  = string,
    Environment = string,
    Pipeline    = string
  })
}

variable "cluster_name" {
  description = "Name of the EKS Cluster"
  type        = string
}

variable "cost_tool_service_account" {
  description = "Cluster Service account for the kubecost workload"
  type        = string
  default     = "kubecost-cost-analyzer"
}

variable "cost_tool_iam_role" {
  description = "AWS IAM role linked to the kubecost Service account"
  type        = string
  default     = "kubecost_role"
}
