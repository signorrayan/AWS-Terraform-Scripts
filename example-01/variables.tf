# variable "ecr_name" { default = "prophet_lambda_repository_prd" }
# variable "lambda_name" { default = "prophet_lambda_prd" }
# variable "role_name" { default = "prophet_lambda_prod_role" }
# variable "s3_policy_name" { default = "s3_object_policy" }

variable "ecr_name" {
  type        = string
  description = "Name for Elastic Container Registry"
}
variable "lambda_name" {
  type = string
}
variable "role_name" {
  type = string
}
variable "s3_policy_name" {
  type = string
}
variable "s3_policy_resource" {
  type = list(string)
}
variable "s3_policy_actions" {
  type = list(string)
}
variable "region_name" {
  type = string
}