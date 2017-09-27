terraform {
  backend "s3" {
    bucket = "terraform-nic"
    key    = "tfconfig/faas-demo"
    region = "eu-west-1"
  }
}

provider "aws" {}
