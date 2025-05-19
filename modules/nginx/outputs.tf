########################################
# nginx Module Outputs
########################################
output "instance_data" {
  description = "nginx Instance Data"
  value = {
    for instance in aws_instance.instance : instance.tags["name"] => {
      id          = instance.id
      public_ip   = instance.public_ip
      domain_name = instance.tags["domain_name"]
    }
  }
}
