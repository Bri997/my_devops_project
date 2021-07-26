variable "instance_ami" {
    type = string
    description = "Server image"
}

variable infra_env {
    type = string
    description = "infrastructure environment"
}

variable infra_role {
  type = string
  description = "infrastructure purpose"
}

variable instance_size {
    type = string
    description = "ec2 web server size"
    default = "t2.micro"
}
