terraform {
  required_providers {
    kubernetes = {
      source = "kubernetes"
    }
  }
}

provider "kubernetes" {
  config_path = "k3s-mtc_node-48140.yaml"
}