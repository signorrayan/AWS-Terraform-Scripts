module "web_server" {
  source                     = "./modules/web_server"
  region                     = var.region
  web_server_ami             = var.web_server_ami
  instance_type              = var.instance_type
  key_name                   = var.key_name
  web_server_custom_port     = var.web_server_custom_port
  backend_server_custom_port = var.backend_server_custom_port
}

module "backend_server" {
  source                     = "./modules/backend_server"
  region                     = var.region
  backend_server_ami         = var.backend_server_ami
  instance_type              = var.instance_type
  key_name                   = var.key_name
  backend_server_custom_port = var.backend_server_custom_port
  web_server_custom_port     = var.web_server_custom_port
}

module "security_groups" {
  source                     = "./modules/security_groups"
  web_server_custom_port     = var.web_server_custom_port
  backend_server_custom_port = var.backend_server_custom_port
}

module "iam_roles" {
  source = "./modules/iam_roles"
}