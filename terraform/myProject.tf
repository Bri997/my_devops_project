
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  backend "s3" {
  bucket         = "bri-devops-bucket"
  key            = "terraform.tfstate"
  region         = "us-east-1"
  profile        = "default"
  dynamodb_table = "my-devops-project"
}
  

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}



data "aws_ami" "ubuntu" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  tags = {

    Name = "My app"

    Environment = "test-dev"
  }

  owners = ["099720109477"] # Canonical


}

variable infra_env {
    type = string
    description = "infrastructure environment"
}

variable default_region {
    type = string
    description = "the region this infrastructure is in"
    default = "us-east-1"
}

variable instance_size {
    type = string
    description = "ec2 web server size"
    default = "t2.micro"
}


module "ec2_app" {
   source = "./modules/ec2"

   infra_env = var.infra_env
   infra_role = "app"
   instance_size = "t2.micro"
   instance_ami = data.aws_ami.ubuntu.id
}

module "ec2_worker" {
   source = "./modules/ec2"

   infra_env = var.infra_env
   infra_role = "worker"
   instance_size = "t2.micro"
   instance_ami = data.aws_ami.ubuntu.id
  
}