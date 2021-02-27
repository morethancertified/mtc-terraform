variable "env" {
  type    = string
  default = "dev"
}

variable "image" {
  type        = map(any)
  description = "Image for container"
  default = {
    dev  = "nodered/node-red:latest"
    prod = "nodered/node-red:latest-minimal"
  }
}

variable "ext_port" {
  type = map(any)


  validation {
    condition     = min(var.ext_port["dev"]...) >= 1980 && max(var.ext_port["dev"]...) <= 65535
    error_message = "The external port must be in the valid port range 1980 - 65535."
  }

  validation {
    condition     = min(var.ext_port["prod"]...) >= 1880 && max(var.ext_port["prod"]...) < 1980
    error_message = "The external port must be in the valid port range 1880 - 1889."
  }
}

variable "int_port" {
  type    = number
  default = 1880

  validation {
    condition     = var.int_port == 1880
    error_message = "The internal port must be 1880."
  }
}

locals {
  container_count = length(lookup(var.ext_port, var.env))
}