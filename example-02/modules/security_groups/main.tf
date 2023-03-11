resource "aws_security_group" "web_server_security_group" {
  name_prefix = "sg_web_server_"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.web_server_custom_port
    to_port     = var.web_server_custom_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "backend_server_security_group" {
  name_prefix = "sg_backend_server_"
  ingress {
    from_port   = var.backend_server_custom_port
    to_port     = var.backend_server_custom_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh_security_group" {
  name_prefix = "sg_ssh_"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "web_server_security_group_id" {
  value = aws_security_group.web_server_security_group.id
}

output "backend_server_security_group_id" {
  value = aws_security_group.backend_server_security_group.id
}

output "ssh_security_group_id" {
  value = aws_security_group.ssh_security_group.id
}