output "docker_container_id" {
  value = docker_container.jobboo-app.id
}

output "docker_container_network_data" {
  value = docker_container.jobboo-app.network_data
}
