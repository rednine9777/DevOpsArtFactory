# # 기존 S3 버킷이 존재하는지 확인
# data "aws_s3_bucket" "existing_bucket" {
#   bucket = "2411-rednine-tf-backend-bucket"
# }

# # 조건부로 S3 버킷 생성
# resource "aws_s3_bucket" "tf-backend-bucket" {
#   count = length(data.aws_s3_bucket.existing_bucket.id) == 0 ? 1 : 0

#   bucket = "2411-rednine-tf-backend-bucket"

#   tags = {
#     Name        = "tf-backend-bucket"
#     Environment = "default"
#   }

#   lifecycle {
#     prevent_destroy = true
#     ignore_changes  = all
#   }
# }

# data "aws_dynamodb_table" "existing_dynamodb_table" {
#   name = "demo-terraform-lock"
# }

# resource "aws_dynamodb_table" "demo_table" {
#   name     = length(data.aws_dynamodb_table.existing_dynamodb_table.id) == 0 ? 1 : 0
#   hash_key = "LockID"

#   billing_mode = "PAY_PER_REQUEST"
#   attribute {
#     name = "LockID"
#     type = "S"
#   }

#   lifecycle {
#     prevent_destroy = true
#     ignore_changes  = all
#   }
# }
