terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "scalable-web/dev/terraform.tfstate"
    region = "eu-central-1"## enter your region
  }
}
provider "aws" {
  region = var.region
}

