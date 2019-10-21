output "project" {
  value     = var.project
  sensitive = true
}

output "user" {
  value     = var.crd_user
  sensitive = true
}

output "crd_code" {
  value     = var.crd_code
  sensitive = true
}

output "crd_pin" {
  value     = var.crd_pin
  sensitive = true
}

output "hostname" {
  value = local.hostname
}

output "gcloud_zone" {
  value = data.google_compute_zones.available.names[0]
}