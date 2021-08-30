data "terraform_remote_state" "kubeconfig" {
  backend = "remote"

  config = {
    organization = "derekops"
    workspaces = {
      name = "mtc-aws"
    }
  }
}