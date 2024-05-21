# https://developer.hashicorp.com/terraform/language/values/variables#custom-validation-rules 

terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}


provider "docker" {}

# variables

variable "container_name" {
  type        = string
  description = "Name of Container"
  default     = "nodered"
}

variable "int_port" {
  type    = number
  default = 1880

  validation {
    condition     = var.int_port == 1880
    error_message = "The internal port for node-red can only be 1880."
  }
}

variable "ext_port" {
  type    = number
  default = 1880

  validation {
    condition     = var.ext_port <= 65535 && var.ext_port > 0
    error_message = "The external port must be in the valid port range 0 - 65535."
  }
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
  name  = var.container_name
  image = docker_image.nodered_image.name
  ports {
    internal = var.int_port
    external = var.ext_port
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