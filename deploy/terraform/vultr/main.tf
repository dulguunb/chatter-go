# main.tf

resource "vultr_instance" "cheapest_server" {
  label   = var.instance_label
  plan    = var.plan_id
  region  = var.region
  os_id   = var.os_id
  hostname = var.instance_label # Often useful to set hostname the same as label
}

output "instance_ipv4_address" {
  description = "The public IPv4 address of the instance."
  value       = vultr_instance.cheapest_server.ipv4_address
}

output "instance_ipv6_address" {
  description = "The public IPv6 address of the instance (if enabled and available)."
  value       = vultr_instance.cheapest_server.v6_main_ip
}