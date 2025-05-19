########################################
# Root Module Outputs
########################################
output "networking_module" {
  value = module.networking
}

output "nginx_module" {
  value = module.nginx
}

output "route53_module" {
  value = module.route53
}
