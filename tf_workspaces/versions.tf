terraform {
  required_providers {
    tfe = {
      version = "~> 0.46.0"
    }
  }
  cloud {
    organization = "twdps"
    workspaces {
      name = "cohort-base-platform-cost-workspaces"
    }
  }
}

provider "tfe" {
  token = var.tfe_token
}
