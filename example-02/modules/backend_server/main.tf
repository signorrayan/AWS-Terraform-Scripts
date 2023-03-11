module "security_group" {
  source = "../security_groups"
  backend_server_custom_port = var.backend_server_custom_port
  web_server_custom_port = var.web_server_custom_port
}

module "iam_role" {
  source = "../iam_roles"
}

module "key_pair" {
  source = "../key_pair"
  key_name = var.key_name
}

resource "aws_instance" "backend_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [module.security_group.backend_server_security_group_id, module.security_group.ssh_security_group_id]
  iam_instance_profile   = module.iam_role.backend_server_instance_profile_name
  tags = {
    Name = "Backend Server"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/awsec2server")
    host        = self.public_ip
  }

  lifecycle {
    create_before_destroy = true
  }
}
