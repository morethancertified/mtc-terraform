variable "ext_port" {
  type = list(any)


  validation {
    condition     = min(var.ext_port...) >= 1880 && max(var.ext_port...) <= 65535
    error_message = "The external port must be in the valid port range 0 - 65535."
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
  container_count = length(var.ext_port)
}