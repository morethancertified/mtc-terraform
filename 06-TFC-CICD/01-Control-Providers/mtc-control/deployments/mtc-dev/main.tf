//--------------------------------------------------------------------
// Variables



//--------------------------------------------------------------------
// Modules
module "compute" {
  source  = "app.terraform.io/organization/compute/aws"
  version = "1.0.1"

  aws_region          = "us-east-1"
  public_key_material = "public-key-material"
  public_sg           = module.networking.public_sg
  public_subnets      = module.networking.public_subnets
}

module "networking" {
  source  = "app.terraform.io/organization/networking/aws"
  version = "1.0.0"

  access_ip  = "0.0.0.0/0"
  aws_region = "us-east-1"
}