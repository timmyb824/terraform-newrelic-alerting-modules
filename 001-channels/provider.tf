terraform {
  required_version = "= 0.14.10"

  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "= 2.22.0"
    }
  }

  #  backend "s3" {}
}

provider "newrelic" {
  account_id = var.nr_account_id
  api_key = var.nr_api_key
  region = var.nr_region
}
