#Deploy Networking Resources

module "networking" {
  source           = "./networking"
  vpc_cidr         = local.vpc_cidr
  private_sn_count = 3
  public_sn_count  = 2
  private_cidrs    = [for i in range(1, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  public_cidrs     = [for i in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  max_subnets      = 20
  access_ip        = var.access_ip
  security_groups  = local.security_groups
  db_subnet_group  = "true"
}

module "database" {
  source                 = "./database"
  db_engine_version      = "5.7.22"
  db_instance_class      = "db.t2.micro"
  dbname                 = var.dbname
  dbuser                 = var.dbuser
  dbpassword             = var.dbpassword
  db_identifier          = "mtc-db"
  skip_db_snapshot       = true
  db_subnet_group_name   = module.networking.db_subnet_group_name[0]
  vpc_security_group_ids = module.networking.db_security_group
}