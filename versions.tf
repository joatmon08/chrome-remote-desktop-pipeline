terraform {
  required_version = "~> 0.12"
  backend "remote" {}
}

provider "google" {
  version     = "~> 2.20"
  project     = var.project
  region      = var.region
}