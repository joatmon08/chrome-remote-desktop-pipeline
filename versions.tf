terraform {
  required_version = "~> 0.12"
  backend "remote" {}
}

provider "google" {
  version = "~> 2.17"
  project = var.project
  region  = var.region
  credentials  = var.credentials
}