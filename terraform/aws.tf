terraform {
  backend "s3" {
    bucket = "marcboudreau-${var.bucket_name}"
    key = "terraform/cloud-account-setup/global.tfstate"
    region = "us-east-1"
  }
  required_version = ">= 0.9.0"
}

provider "aws" {
}
