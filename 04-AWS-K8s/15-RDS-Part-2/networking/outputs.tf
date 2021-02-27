# --- networking/outputs.tf ---

output "vpc_id" {
  value = aws_vpc.mtc_vpc.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.mtc_rds_subnetgroup.*.name
}

output "db_security_group" {
  value = aws_security_group.mtc_sg["rds"].id
}