output "backend_address_pool_id" {
  description = "The resource id of the backend address pool created for the load balancer."
  value       = "${element(concat(azurerm_lb_backend_address_pool.lb_azure.*.id, list("")), 0)}"
}

output "inbound_nat_rules_ids" {
  description = "The inbound NAT rule IDs created for the load balancer."
  value       = "${concat(azurerm_lb_nat_pool.lb_azure.*.id, list(""))}"
}

output "public_ip_address" {
  description = "The load balancer public IP address."
  value       = "${element(concat(azurerm_public_ip.lb_azure.*.ip_address, list("")), 0)}"
}

output "public_fqdn" {
  description = "The load balancer public fully qualified domain name."
  value       = "${element(concat(azurerm_public_ip.lb_azure.*.fqdn, list("")), 0)}"
}
