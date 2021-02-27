locals {
  security_groups = {
    public = {
      name        = "public_sg"
      description = "public access"
      ingress = {
        ssh = {
          from        = 22
          to          = 22
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
      }
    }
  }
}