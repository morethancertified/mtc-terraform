terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

# download nodered image

provider "docker" {}