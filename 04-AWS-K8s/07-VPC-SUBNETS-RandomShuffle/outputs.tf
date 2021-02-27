output "vpc_id" {
  value = aws_vpc.mtc_vpc.id
}

output "public_subnets" {
  value = aws_subnet.pc_public_subnet.*.id
}

output "private_subnets" {
  value = aws_subnet.pc_private_subnet.*.id
}