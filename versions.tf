terraform {
  required_version = ">= 1.1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.0"
    }
  }

  cloud {
    organization = "twdps"
    workspaces {
      tags = ["cohort-base-platform-cost"]
    }
  }

  #backend "remote" {
  #  hostname     = "app.terraform.io"
  #  organization = "twdps"
  #  workspaces {
  #    prefix = "cohort-base-platform-cost-"
  #  }
  #}
}

provider "aws" {
  region = var.cluster_region
  alias  = "cluster"
  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id}:role/${var.assume_role}"
    session_name = "cohort-base-platform-cur"
  }
}

provider "aws" {
  # CUR is only available in us-east-1.
  alias  = "cur"
  region = var.cur_region

  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id}:role/${var.assume_role}"
    session_name = "cohort-base-platform-cur"
  }
}
