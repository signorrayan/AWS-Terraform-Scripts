ecr_name           = "aws_terraform_lambda_repository_prd"
lambda_name        = "aws_terraform_lambda_prd"
role_name          = "aws_terraform_lambda_prd_role"
s3_policy_name     = "aws_terraform_prd_s3_object_policy"
s3_policy_resource = ["arn:aws:s3:::YOUR-S3-Bucket-Name-HERE/*", "arn:aws:s3:::YOUR-S3-Bucket-Name-HERE"]
s3_policy_actions  = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
region_name        = "YOU-Account-Region-HERE"