
output "west_consul" {
  value = module.west.consul_ui
}
output "west_consul_ip" {
    value = module.west.consul_ip
}

output "west_ssh" {
    value = "ssh ubuntu@${module.west.consul_ip}"
}

output "east_consul" {
  value = module.east.consul_ui
}

output "east_consul_ip" {
    value = module.east.consul_ip
}


output "east_ssh" {
    value = "ssh ubuntu@${module.east.consul_ip}"
}
