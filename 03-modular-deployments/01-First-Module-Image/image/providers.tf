terraform {
  required_providers {
    docker = {
      source  = "terraform-providers/docker"
      version = "~> 2.7.2"
    }
  }
}


provider "docker" {}