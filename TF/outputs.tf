output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "cluster_zone" {
  value = google_container_cluster.primary.location
}

output "artifact_registry_repo" {
  value = google_artifact_registry_repository.docker_repo.repository_id
}

output "get_credentials_command" {
  description = "Пусни тази команда, за да свържеш kubectl с клъстъра"
  value       = "gcloud container clusters get-credentials ${google_container_cluster.primary.name} --zone ${google_container_cluster.primary.location} --project ${var.project_id}"
}
