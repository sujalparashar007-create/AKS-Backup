resource_group_name = "rg-aks-lab"
location            = "East US"

vnet_name          = "vnet-aks-lab"
vnet_address_space = ["10.10.0.0/16"]

aks_subnet_name             = "snet-aks"
aks_subnet_address_prefixes = ["10.10.0.0/22"]

aks_cluster_name = "aks-lab"
aks_dns_prefix   = "akslab"

nat_gateway_name                = "nat-aks-lab"
nat_public_ip_name              = "pip-nat-aks-lab"
nat_public_ip_allocation_method = "Static"
nat_gateway_sku                 = "Standard"


backup_snapshot_rg_name           = "rg-aks-backup-snapshots"
backup_storage_account_name       = "staksbackuplab01"
backup_storage_container_name     = "aks-backup"
backup_vault_name                 = "bv-aks-lab"
backup_policy_name                = "bp-aks-lab"
backup_schedule_intervals         = ["R/2024-01-01T02:00:00+00:00/P1D"]
backup_time_zone                  = "UTC"
backup_default_retention_duration = "P7D"
test_vm_admin_password            = "Sujalparashar001"

backup_instance_name       = "bi-aks-lab"
backup_included_namespaces = ["default"]

# --- DR Environment (Phase 7) ---
dr_resource_group_name             = "rg-aks-lab-dr"
dr_vnet_name                       = "vnet-aks-lab-dr"
dr_vnet_address_space              = ["10.20.0.0/16"]
dr_subnet_name                     = "snet-aks-dr"
dr_subnet_address_prefixes         = ["10.20.0.0/22"]
dr_bastion_subnet_address_prefixes = ["10.20.4.0/26"]
dr_nat_public_ip_name              = "pip-nat-aks-lab-dr"
dr_nat_gateway_name                = "nat-aks-lab-dr"
dr_aks_cluster_name                = "aks-lab-dr"
dr_aks_dns_prefix                  = "akslabdr"
dr_test_vm_admin_password          = "Sujalparashar002"
dr_bastion_name                    = "bastion-aks-lab-dr"
dr_test_vm_name                    = "vm-aks-dr-test"
dr_pod_cidr                        = "10.245.0.0/16"
dr_service_cidr                    = "10.1.0.0/16"
dr_dns_service_ip                  = "10.1.0.10"