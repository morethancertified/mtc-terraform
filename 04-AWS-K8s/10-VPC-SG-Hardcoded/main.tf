#Deploy Networking Resources

locals {
  vpc_cidr = "10.111.0.0/16"
}


module "networking" {
  source           = "./networking"
  vpc_cidr         = local.vpc_cidr
  private_sn_count = 3
  public_sn_count  = 2
  private_cidrs    = [for i in range(1, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  public_cidrs     = [for i in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  max_subnets      = 20
  access_ip        = var.access_ip
}