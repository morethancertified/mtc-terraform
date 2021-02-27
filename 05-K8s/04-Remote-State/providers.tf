locals {
  config = data.terraform_remote_state.kubeconfig.outputs.kubeconfig
}

terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "kubernetes" {
  config_path = split("/", local.config[0])[1]
}