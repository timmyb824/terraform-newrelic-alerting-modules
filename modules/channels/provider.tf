terraform {
  required_version = "= 0.14.10"

  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "= 2.22.0"
    }
  }
}

