variable access_key {
  type = string
}
variable secret_key {
  type = string
}

provider "aws" {
  region     = local.default_region
  access_key = var.access_key
  secret_key = var.secret_key
}

locals {
  project_name   = "big-data-in-aws-demo"
  default_region = "us-east-1"
  landing_s3     = "${local.project_name}-lnd"
  transformed_s3 = "${local.project_name}-transformed"
  marts_s3       = "${local.project_name}-marts"
  tags           = { "personal_project" : "aws-bigdata-demo" }
}