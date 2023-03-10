output "web_server_instance_profile_name" {
  value = aws_iam_instance_profile.web_server_instance_profile.name
}

output "backend_server_instance_profile_name" {
  value = aws_iam_instance_profile.backend_server_instance_profile.name
}