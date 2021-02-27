terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.8.0"
    }
  }
}


provider "docker" {}