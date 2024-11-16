resource "docker_image" "jobboo-img" {
  name         = "akidev9777/jobboo"
  keep_locally = false
}

resource "docker_container" "jobboo-app" {
  image = docker_image.jobboo-img.image_id
  name  = "tutorial"
  ports {
    internal = 8080
    external = 8080
  }
}
