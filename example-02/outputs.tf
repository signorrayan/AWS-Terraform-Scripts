output "web_server_public_ip" {
  value = module.web_server.web_server_public_ip
}

output "backend_server_public_ip" {
  value = module.backend_server.backend_server_public_ip
}