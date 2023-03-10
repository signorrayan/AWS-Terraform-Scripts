module "security_group" {
  source = "../security_groups"
  web_server_custom_port = var.web_server_custom_port
  backend_server_custom_port = var.backend_server_custom_port
}

module "iam_role" {
  source = "../iam_roles"
}

resource "aws_instance" "web_server" {
  ami                    = var.web_server_ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [module.security_group.web_server_security_group_id, module.security_group.ssh_security_group_id]
  iam_instance_profile   = module.iam_role.web_server_instance_profile_name

  tags = {
    Name = "Web Server"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/awsec2server")
    host        = self.public_ip
  }

  provisioner "file" {
    content     = file("./modules/web_server/index.html")
    destination = "/tmp/index.html"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# resource "aws_key_pair" "webserver_key_pair" {
#   key_name   = var.key_name
#   public_key = file("~/.ssh/awsec2server.pub")
# }
