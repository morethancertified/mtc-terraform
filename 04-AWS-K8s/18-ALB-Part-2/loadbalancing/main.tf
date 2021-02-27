# --- loadbalancing/main.tf ---

resource "aws_lb" "mtc_lb" {
  name            = "mtc-loadbalancer"
  subnets         = var.public_subnets
  security_groups = [var.public_sg]
  idle_timeout    = 400
}