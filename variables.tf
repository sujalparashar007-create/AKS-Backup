variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vnet_name" {
  description = "Name of the AKS virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space of the AKS virtual network"
  type        = list(string)
}

variable "aks_subnet_name" {
  description = "Name of the AKS subnet"
  type        = string
}

variable "aks_subnet_address_prefixes" {
  description = "Address prefixes for the AKS subnet"
  type        = list(string)
}

variable "aks_cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "aks_dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "nat_gateway_name" {
  description = "Name of the NAT Gateway"
  type        = string
}

variable "nat_public_ip_name" {
  description = "Name of the NAT Gateway public IP"
  type        = string
}

variable "nat_public_ip_allocation_method" {
  description = "Allocation method for the NAT Gateway public IP"
  type        = string
  default     = "Static"
}

variable "nat_gateway_sku" {
  description = "SKU of the NAT Gateway"
  type        = string
  default     = "Standard"
}

variable "test_vm_admin_password" {
  description = "Admin password for the AKS test VM"
  type        = string
  sensitive   = true
}

variable "backup_snapshot_rg_name" {
  description = "Resource group for AKS Backup volume snapshots"
  type        = string
  default     = "rg-aks-backup-snapshots"
}

variable "backup_storage_account_name" {
  description = "Storage account for AKS Backup extension data"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.backup_storage_account_name))
    error_message = "Storage account name must be 3-24 characters, lowercase letters and numbers only."
  }
}

variable "backup_storage_container_name" {
  description = "Blob container for AKS Backup extension data"
  type        = string
  default     = "aks-backup"
}

variable "backup_vault_name" {
  description = "Name of the Azure Backup vault for AKS"
  type        = string
  default     = "bv-aks-lab"
}

variable "backup_policy_name" {
  description = "Name of the AKS Backup policy"
  type        = string
  default     = "bp-aks-lab"
}

variable "backup_schedule_intervals" {
  description = "ISO 8601 repeating time intervals for the AKS Backup schedule"
  type        = list(string)
  default     = ["R/2024-01-01T02:00:00+00:00/P1D"]
}

variable "backup_time_zone" {
  description = "Time zone for the AKS Backup schedule"
  type        = string
  default     = "UTC"
}

variable "backup_default_retention_duration" {
  description = "ISO 8601 duration for the default backup retention period"
  type        = string
  default     = "P7D"
}

variable "backup_instance_name" {
  description = "Name of the AKS Backup Instance"
  type        = string
  default     = "bi-aks-lab"
}

variable "backup_included_namespaces" {
  description = "Kubernetes namespaces to include in the backup"
  type        = list(string)
  default     = ["default"]
}

variable "dr_resource_group_name" {
  description = "Name of the DR resource group"
  type        = string
  default     = "rg-aks-lab-dr"
}

variable "dr_vnet_name" {
  description = "Name of the DR virtual network"
  type        = string
  default     = "vnet-aks-lab-dr"
}

variable "dr_vnet_address_space" {
  description = "Address space of the DR virtual network"
  type        = list(string)
  default     = ["10.20.0.0/16"]
}

variable "dr_subnet_name" {
  description = "Name of the DR AKS subnet"
  type        = string
  default     = "snet-aks-dr"
}

variable "dr_subnet_address_prefixes" {
  description = "Address prefixes for the DR AKS subnet"
  type        = list(string)
  default     = ["10.20.0.0/22"]
}

variable "dr_bastion_subnet_address_prefixes" {
  description = "Address prefixes for the DR AzureBastionSubnet"
  type        = list(string)
  default     = ["10.20.4.0/26"]
}

variable "dr_nat_public_ip_name" {
  description = "Name of the DR NAT Gateway public IP"
  type        = string
  default     = "pip-nat-aks-lab-dr"
}

variable "dr_nat_gateway_name" {
  description = "Name of the DR NAT Gateway"
  type        = string
  default     = "nat-aks-lab-dr"
}

variable "dr_aks_cluster_name" {
  description = "Name of the DR AKS cluster"
  type        = string
  default     = "aks-lab-dr"
}

variable "dr_aks_dns_prefix" {
  description = "DNS prefix for the DR AKS cluster"
  type        = string
  default     = "akslabdr"
}

variable "dr_test_vm_admin_password" {
  description = "Admin password for the DR test VM"
  type        = string
  sensitive   = true
}

variable "dr_bastion_name" {
  description = "Name of the DR Bastion host"
  type        = string
  default     = "bastion-aks-lab-dr"
}

variable "dr_test_vm_name" {
  description = "Name of the DR test VM"
  type        = string
  default     = "vm-aks-dr-test"
}

variable "dr_pod_cidr" {
  description = "CIDR range for Kubernetes pods in the DR cluster"
  type        = string
  default     = "10.245.0.0/16"
}

variable "dr_service_cidr" {
  description = "CIDR range for Kubernetes services in the DR cluster"
  type        = string
  default     = "10.1.0.0/16"
}

variable "dr_dns_service_ip" {
  description = "IP address of the Kubernetes DNS service in the DR cluster (must be within dr_service_cidr)"
  type        = string
  default     = "10.1.0.10"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = { Environment = "Lab", Project = "AKS", ManagedBy = "Terraform" }
}