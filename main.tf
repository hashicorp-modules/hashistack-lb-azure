# ---------------------------------------------------------------------------------------------------------------------
#  Azure General Resources
# ---------------------------------------------------------------------------------------------------------------------
resource "azurerm_resource_group" "lb_azure" {
  name     = "${var.name}"
  location = "${var.azure_region}"
}

# ---------------------------------------------------------------------------------------------------------------------
#  Azure Load Balancer Resources
# ---------------------------------------------------------------------------------------------------------------------
resource "azurerm_public_ip" "lb_azure" {
  name                = "${var.name}"
  location            = "${var.azure_region}"
  resource_group_name = "${azurerm_resource_group.lb_azure.name}"
  allocation_method   = "Static"
  domain_name_label   = "${var.name}"
}

resource "azurerm_lb" "lb_azure" {
  name                = "lb_azure"
  location            = "${var.azure_region}"
  resource_group_name = "${azurerm_resource_group.lb_azure.name}"

  frontend_ip_configuration {
    name                 = "${var.name}"
    public_ip_address_id = "${azurerm_public_ip.lb_azure.id}"
  }
}

resource "azurerm_lb_backend_address_pool" "lb_azure" {
  resource_group_name = "${azurerm_resource_group.lb_azure.name}"
  loadbalancer_id     = "${azurerm_lb.lb_azure.id}"
  name                = "${var.name}"
}

resource "azurerm_lb_nat_pool" "lb_azure" {
  count                          = "${var.azure_nat_pool_count}"
  name                           = "ssh"
  resource_group_name            = "${azurerm_resource_group.lb_azure.name}"
  loadbalancer_id                = "${azurerm_lb.lb_azure.id}"
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50119
  backend_port                   = 22
  frontend_ip_configuration_name = "${var.name}"
}

resource "azurerm_lb_probe" "lb_azure" {
  resource_group_name = "${azurerm_resource_group.lb_azure.name}"
  loadbalancer_id     = "${azurerm_lb.lb_azure.id}"
  name                = "${var.name}"
  port                = 80
}
