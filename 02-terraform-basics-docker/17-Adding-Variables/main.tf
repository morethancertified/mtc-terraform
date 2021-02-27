terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}


provider "docker" {}

# variables


variable "int_port" {
  type    = number
  default = 1880
}

variable "ext_port" {
  type    = number
  default = 1880
}

variable "container_count" {
  type    = number
  default = 2
}

# download nodered image

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

# start the container

resource "docker_container" "nodered_container" {
  name  = "nodered"
  image = docker_image.nodered_image.latest
  ports {
    internal = var.int_port
    external = var.ext_port
  }
}

#Output the IP Address of the Container
output "ip-address" {
  value = docker_container.nodered_container.ip_address
}

output "container-name" {
  value = docker_container.nodered_container.name
}
