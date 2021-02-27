output "instance" {
  value     = aws_instance.mtc_node[*]
  sensitive = true
}

output "instance_port" {
  value = aws_lb_target_group_attachment.mtc_tg_attach[0].port
}