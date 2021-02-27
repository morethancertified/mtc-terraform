terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "derekops"

    workspaces {
      name = "mtc-aws"
    }
  }
}