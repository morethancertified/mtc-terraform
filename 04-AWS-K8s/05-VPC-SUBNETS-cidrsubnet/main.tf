#Deploy Networking Resources

module "networking" {
  source           = "./networking"
  vpc_cidr         = "10.123.0.0/16"
  private_sn_count = 3
  public_sn_count  = 2
  private_cidrs    = [for i in range(1, 255, 2) : cidrsubnet("10.123.0.0/16", 8, i)]
  public_cidrs     = [for i in range(2, 255, 2) : cidrsubnet("10.123.0.0/16", 8, i)]
}