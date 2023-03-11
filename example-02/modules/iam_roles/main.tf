resource "aws_iam_instance_profile" "web_server_instance_profile" {
  name_prefix = "web_server_"
  role        = aws_iam_role.web_server_role.name
}

resource "aws_iam_role" "web_server_role" {
  name_prefix = "web_server_"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "backend_server_instance_profile" {
  name_prefix = "backend_server_"
  role        = aws_iam_role.backend_server_role.name
}

resource "aws_iam_role" "backend_server_role" {
  name_prefix = "backend_server_"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
