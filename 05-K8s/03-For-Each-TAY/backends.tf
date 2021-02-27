terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "derekops"

    workspaces {
      name = "mtc-k8s"
    }
  }
}