#Deploy Networking Resources

module "networking" {
  source   = "./networking"
  vpc_cidr = "10.123.0.0/16"
}