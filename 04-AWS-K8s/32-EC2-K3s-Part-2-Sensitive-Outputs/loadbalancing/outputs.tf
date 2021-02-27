output "lb_target_group_arn" {
  value = aws_lb_target_group.mtc_tg.arn
}

output "lb_endpoint" {
  value = aws_lb.mtc_lb.endpoint
}