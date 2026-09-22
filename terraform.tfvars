resource_group_name = "rg-aks-lab"
location            = "East US"

vnet_name          = "vnet-aks-lab"
vnet_address_space = ["10.10.0.0/16"]

aks_subnet_name             = "snet-aks"
aks_subnet_address_prefixes = ["10.10.0.0/22"]

aks_cluster_name = "aks-lab"
aks_dns_prefix   = "akslab"

nat_gateway_name     = "nat-aks-lab"
nat_public_ip_name   = "pip-nat-aks-lab"
nat_public_ip_prefix = "Static"
nat_gateway_sku      = "Standard"

test_vm_admin_password = "Sujalparashar001"