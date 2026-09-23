module "dr_aks" {
  source = "./modules/dr-aks"

  location                        = var.location
  resource_group_name             = var.dr_resource_group_name
  vnet_name                       = var.dr_vnet_name
  vnet_address_space              = var.dr_vnet_address_space
  aks_subnet_name                 = var.dr_subnet_name
  aks_subnet_address_prefixes     = var.dr_subnet_address_prefixes
  bastion_subnet_address_prefixes = var.dr_bastion_subnet_address_prefixes
  nat_public_ip_name              = var.dr_nat_public_ip_name
  nat_gateway_name                = var.dr_nat_gateway_name
  aks_cluster_name                = var.dr_aks_cluster_name
  aks_dns_prefix                  = var.dr_aks_dns_prefix
  test_vm_name                    = var.dr_test_vm_name
  test_vm_admin_password          = var.dr_test_vm_admin_password
  bastion_name                    = var.dr_bastion_name
  pod_cidr                        = var.dr_pod_cidr
  service_cidr                    = var.dr_service_cidr
  dns_service_ip                  = var.dr_dns_service_ip
  tags                            = var.tags
}

