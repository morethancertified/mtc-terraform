# --- root/main.tf --- 

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
  vpc_security_group_ids = [module.networking.db_security_group]
}

module "loadbalancing" {
  source                  = "./loadbalancing"
  public_sg               = module.networking.public_sg
  public_subnets          = module.networking.public_subnets
  tg_port                 = 8000
  tg_protocol             = "HTTP"
  vpc_id                  = module.networking.vpc_id
  elb_healthy_threshold   = 2
  elb_unhealthy_threshold = 2
  elb_timeout             = 3
  elb_interval            = 30
  listener_port           = 80
  listener_protocol       = "HTTP"
}

module "compute" {
  source              = "./compute"
  public_sg           = module.networking.public_sg
  public_subnets      = module.networking.public_subnets
  instance_count      = 2
  instance_type       = "t3.micro"
  vol_size            = "20"
  public_key_path     = "/home/ubuntu/.ssh/mtckey.pub"
  key_name            = "mtckey"
  dbname              = var.dbname
  dbuser              = var.dbuser
  dbpassword          = var.dbpassword
  db_endpoint         = module.database.db_endpoint
  user_data_path      = "${path.root}/userdata.tpl"
  lb_target_group_arn = module.loadbalancing.lb_target_group_arn
}