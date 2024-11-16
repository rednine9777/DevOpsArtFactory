resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "nginx"

  ports {
    internal = 80
    external = 8080
  }
}

output "port" {
  value = docker_container.nginx.ports[0].external
}

check "health_check" {
  data "http" "nginx" {
    url = "http://localhost:8080"
  }

  assert {
    condition     = data.http.nginx.status_code == 200
    error_message = "${data.http.nginx.url} returned an unhealthy status code"
  }
}
