terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket         = "tf-rednine-9777-apnortheast2-tfstate"
    key            = "provisioning/terraform/ecr/demo_id/ap-northeast-2/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "tf-rednine-9777-terraform-lock"
  }
}

