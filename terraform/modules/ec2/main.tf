resource "aws_instance" "web_server" {
  ami           = var.instance_ami
  instance_type = var.instance_size


  tags = {
    Name        = "mydevops-${var.infra_env}-web"
    Role        = var.infra_role
    Project     = "mydevops_project"
    Environment = var.infra_env
    ManagedBy   = "terraform"
  }
}

resource "aws_eip" "web_addr" {
 
  vpc      = true

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name        = "mydevops-${var.infra_env}-web-address"
    Role        = var.infra_role
    Project     = "mydevops_projects"
    Environment = var.infra_env
    ManagedBy   = "terraform"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.web_server.id
  allocation_id = aws_eip.web_addr.id
}