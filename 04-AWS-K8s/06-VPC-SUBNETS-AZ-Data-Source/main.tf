#Deploy Networking Resources

module "networking" {
  source        = "./networking"
  vpc_cidr      = "10.123.0.0/16"
  private_cidrs = ["10.123.1.0/24", "10.123.3.0/24", "10.123.5.0/24"]
  public_cidrs  = ["10.123.2.0/24", "10.123.4.0/24"]
}