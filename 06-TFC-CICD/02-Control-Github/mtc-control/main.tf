resource "github_repository" "mtc_repo" {
  name             = "mtc-dev-repo"
  description      = "VPC and Compute resources"
  auto_init        = true
  license_template = "mit"

  visibility = "public"
}

resource "github_branch_default" "default" {
  repository = github_repository.mtc_repo.name
  branch     = "main"
}


resource "github_repository_file" "maintf" {
  repository          = github_repository.mtc_repo.name
  branch              = "main"
  file                = "main.tf"
  content             = file("./deployments/dev/main.tf")
  commit_message      = "Managed by Terraform"
  commit_author       = "derek"
  commit_email        = "derek@morethancertified.com"
  overwrite_on_create = true
}