resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  count = var.deploy_container ? 1 : 0 # 조건문을 사용하여 컨테이너 생성 여부 결정
  image = docker_image.nginx.image_id
  name  = "nginx_container"
  ports {
    internal = 80
    external = 80
  }

}
