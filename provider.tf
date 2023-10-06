provider "aws" {
  region = var.region != "" ? var.region : "us-east-1"
}
