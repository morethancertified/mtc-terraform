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

resource "random_string" "random"{
  count = var.container_count
  length = 4
  special = false
  upper = false
}

# download nodered image

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

# start the container

resource "docker_container" "nodered_container" {
  count = var.container_count
  name  = join("-",["nodered", random_string.random[count.index].result])
  image = docker_image.nodered_image.name
  ports {
    internal = var.int_port
    # external = var.ext_port
  }
}

#Output the IP Address of the Container
output "ip-address" {
  value = [for i in docker_container.nodered_container[*] :
  join(":", [i.network_data[0].ip_address], i.ports[*]["external"])]
  description = "The IP address of the container"
}

output "container-name" {
  value = docker_container.nodered_container[*].name
}
