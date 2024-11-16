resource "aws_subnet" "private-a" {
  vpc_id            = aws_vpc.main.id # VPC ID를 참조하여 이 서브넷이 속할 VPC를 지정
  cidr_block        = "10.0.1.0/24"   # 서브넷의 네트워크 범위를 정의하는 CIDR 블록
  availability_zone = local.zone1     # 서브넷을 생성할 가용 영역을 지정

  tags = {
    "Name"                                                 = "${local.env}-private-${local.zone1}" # 서브넷에 추가할 태그의 이름을 설정 (환경과 가용 영역에 따라 동적으로 지정)
    "kubernetes.io/role/internal-elb"                      = "1"                                   # 이 서브넷을 Kubernetes에서 내부 로드 밸런서 (internal ELB)용으로 사용하도록 표시
    "kubernetes.io/cluster/${local.env}-${local.eks_name}" = "owned"                               # Optional 로 멀티클러스터를 구성해서 관리할지 여부 (shared or owned)
  }
}

resource "aws_subnet" "private-b" {
  vpc_id            = aws_vpc.main.id # VPC ID를 참조하여 이 서브넷이 속할 VPC를 지정
  cidr_block        = "10.0.2.0/24"   # 서브넷의 네트워크 범위를 정의하는 CIDR 블록
  availability_zone = local.zone2     # 서브넷을 생성할 가용 영역을 지정

  tags = {
    "Name"                                                 = "${local.env}-private-${local.zone2}" # 서브넷에 추가할 태그의 이름을 설정 (환경과 가용 영역에 따라 동적으로 지정)
    "kubernetes.io/role/internal-elb"                      = "1"                                   # 이 서브넷을 Kubernetes에서 내부 로드 밸런서 (internal ELB)용으로 사용하도록 표시
    "kubernetes.io/cluster/${local.env}-${local.eks_name}" = "owned"                               # Optional 로 멀티클러스터를 구성해서 관리할지 여부 (shared or owned)
  }
}

resource "aws_subnet" "public-a" {
  vpc_id                  = aws_vpc.main.id # VPC ID를 참조하여 이 서브넷이 속할 VPC를 지정
  cidr_block              = "10.0.100.0/24" # 서브넷의 네트워크 범위를 정의하는 CIDR 블록
  availability_zone       = local.zone1     # 서브넷을 생성할 가용 영역을 지정
  map_public_ip_on_launch = true            // 퍼블릭 아이피 자동 할당 활성화

  tags = {
    "Name"                                                 = "${local.env}-public-${local.zone1}" # 서브넷에 추가할 태그의 이름을 설정 (환경과 가용 영역에 따라 동적으로 지정)
    "kubernetes.io/role/elb"                               = "1"                                  # # 중요 !!! 이 태그가 지정되어야 ALB 가 생성됨
    "kubernetes.io/cluster/${local.env}-${local.eks_name}" = "owned"                              # Optional 로 멀티클러스터를 구성해서 관리할지 여부 (shared or owned)
  }
}

resource "aws_subnet" "public-b" {
  vpc_id                  = aws_vpc.main.id # VPC ID를 참조하여 이 서브넷이 속할 VPC를 지정
  cidr_block              = "10.0.101.0/24" # 서브넷의 네트워크 범위를 정의하는 CIDR 블록
  availability_zone       = local.zone2     # 서브넷을 생성할 가용 영역을 지정
  map_public_ip_on_launch = true            // 퍼블릭 아이피 자동 할당 활성화

  tags = {
    "Name"                                                 = "${local.env}-public-${local.zone2}" # 서브넷에 추가할 태그의 이름을 설정 (환경과 가용 영역에 따라 동적으로 지정)
    "kubernetes.io/role/elb"                               = "1"                                  # 중요 !!! 이 태그가 지정되어야 ALB 가 생성됨
    "kubernetes.io/cluster/${local.env}-${local.eks_name}" = "owned"                              # Optional 로 멀티클러스터를 구성해서 관리할지 여부 (shared or owned)
  }
}
