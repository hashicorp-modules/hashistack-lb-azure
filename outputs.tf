output "backend_address_pool_id" {
    value = "${element(concat(azurerm_lb_backend_address_pool.lb_azure.*.id, list("")), 0)}"
}
output "inbound_nat_rules_ids" {
    value = "${element(concat(azurerm_lb_nat_pool.lb_azure.*.id, list("")), 0)}"
}
output "public_ip_address" {
    value = "${element(concat(azurerm_public_ip.lb_azure.*.ip_address, list("")), 0)}"
}

output "public_fqdn" {
    value = "${element(concat(azurerm_public_ip.lb_azure.*.fqdn, list("")), 0)}"
}