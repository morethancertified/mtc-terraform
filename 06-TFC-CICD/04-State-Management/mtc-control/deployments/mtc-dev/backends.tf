terraform {
  backend "remote" {
    organization = "organization-name"

    workspaces {
      name = "mtc-aws-dev"
    }
  }
}