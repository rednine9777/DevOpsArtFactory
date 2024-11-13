resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16" # VPC의 네트워크 범위를 정의하는 CIDR 블록

  enable_dns_hostnames = true # VPC 내에서 DNS 호스트 이름을 활성화 (예: EC2 인스턴스에 대한 기본 DNS 이름 제공)
  enable_dns_support   = true # VPC에서 DNS 해석 지원 활성화

  tags = {
    Name = "${local.env}-main" # VPC에 추가할 태그를 정의 (환경 변수 local.env를 사용하여 태그 이름 설정)
  }
}
