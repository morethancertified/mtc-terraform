output "name" {
  value       = module.container[*].container_name
  description = "The name of the container"
}

output "ip-address" {
  value       = flatten(module.container[*].ip_address)
  description = "The IP address and external port of the container"
}