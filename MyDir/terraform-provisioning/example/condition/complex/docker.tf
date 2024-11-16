locals {
  default_host_path = abspath(path.module) # 절대 경로로 변
}

output "host_path" {
  value = local.default_host_path
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "nginx_container_${var.environment}"
  ports {
    internal = 80
    external = var.environment == "prod" ? 80 : 8080
  }

  dynamic "volumes" {
    for_each = var.enable_volume ? [1] : []
    content {
      host_path      = local.default_host_path
      container_path = var.container_path
    }
  }

  # 메모리 제한 설정
  memory = var.memory_limit * 1024 * 1024


  # Docker 재시작 정책
  # "on-failure": 컨테이너가 비정상 종료될 때만 재시작합니다. 이는 주로 프로덕션 환경에서 오류 발생 시 재시작하도록 설정하는 데 유용합니다.
  # "unless-stopped": 컨테이너가 중지 명령을 받을 때까지 자동으로 재시작합니다. 이는 개발 환경에서 컨테이너가 계속 실행되도록 설정할 때 유용합니다.
  # 재시작 설정
  restart = var.environment == "prod" ? "on-failure" : "unless-stopped"

  # 환경 변수 설정
  env = [
    "ENV=${var.environment}",
    "MEMORY_LIMIT=${var.memory_limit}MB"
  ]

}
