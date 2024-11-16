variable "container_external_port" {
  type    = number
  default = 8080
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "nginx"

  ports {
    internal = 80
    external = var.container_external_port
  }

  lifecycle {
    precondition {
      condition     = var.container_external_port != 80
      error_message = "Don't use Known port(http : 80)"
    }

    postcondition {
      condition     = can(self.id)
      error_message = "Nginx container cannot created!!!"
    }

    # postcondition {
    #   condition     = self.must_run != "true"
    #   error_message = "nginx not running"
    # }

  }
}

output "docker_container_id" {
  value = docker_container.nginx.id

  precondition {
    condition     = docker_container.nginx.id == "390db1dd5166219ea4c8625af75d8cece72e434eb79fa3a3a7bf1a1057804b1b"
    error_message = "Don`t Destroy"
  }
}
