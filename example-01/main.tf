resource "aws_ecr_repository" "aws_terraform_lambda_prd" {
  name = var.ecr_name
}

resource "docker_image" "aws_terraform_lambda_prd" {
  name = "${aws_ecr_repository.aws_terraform_lambda_prd.repository_url}:latest"
  build {
    context    = "${path.module}/package"
    dockerfile = "Dockerfile"
  }
}

resource "docker_registry_image" "aws_terraform_lambda_prd" {
  name = docker_image.aws_terraform_lambda_prd.name
}

resource "aws_lambda_function" "prophet_lambda_prd" {
  function_name = var.lambda_name
  role          = aws_iam_role.lambda_exec.arn
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.aws_terraform_lambda_prd.repository_url}:latest"
  depends_on    = [docker_registry_image.aws_terraform_lambda_prd]
  timeout       = 60
  memory_size   = 256
}

resource "aws_iam_role" "lambda_exec" {
  name = var.role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "s3_object_policy" {
  name = var.s3_policy_name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = var.s3_policy_actions,
        Resource = var.s3_policy_resource
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_object_policy_attachment" {
  policy_arn = aws_iam_policy.s3_object_policy.arn
  role       = aws_iam_role.lambda_exec.name
}

resource "aws_iam_role_policy_attachment" "lambda_exec_basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_exec.name
}

resource "aws_iam_role_policy_attachment" "ecr_pull_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.lambda_exec.name
}