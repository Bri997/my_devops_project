
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "My Server"

    Project = "my_devops_project"

    Eviromnent = "test"

    ManagedBy = "Terraform"
  }
}
resource "aws_eip" "my_app_eip" {


  vpc = true

  tags = {
    Name = "My Server EIP"

    Project = "my_devops_project"

    Eviromnent = "test"

    ManagedBy = "Terraform"
  }

}
# allow the same IP address with shutdown of instance 
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.app_server.id
  allocation_id = aws_eip.my_app_eip.id
}