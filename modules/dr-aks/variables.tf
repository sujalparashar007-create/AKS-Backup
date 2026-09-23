variable "resource_group_name" {
  description = "Name of the DR resource group"
  type        = string
}

variable "location" {
  description = "Azure region for all DR resources"
  type        = string
}

variable "vnet_name" {
  description = "Name of the DR virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space of the DR virtual network"
  type        = list(string)
}

variable "aks_subnet_name" {
  description = "Name of the DR AKS subnet"
  type        = string
}

variable "aks_subnet_address_prefixes" {
  description = "Address prefixes for the DR AKS subnet"
  type        = list(string)
}

variable "bastion_subnet_address_prefixes" {
  description = "Address prefixes for the AzureBastionSubnet"
  type        = list(string)
}

variable "nat_public_ip_name" {
  description = "Name of the NAT Gateway public IP"
  type        = string
}

variable "nat_gateway_name" {
  description = "Name of the NAT Gateway"
  type        = string
}

variable "aks_cluster_name" {
  description = "Name of the DR AKS cluster"
  type        = string
}

variable "aks_dns_prefix" {
  description = "DNS prefix for the DR AKS cluster"
  type        = string
}

variable "node_vm_size" {
  description = "VM size for the AKS node pool and test VM"
  type        = string
  default     = "Standard_D2alds_v7"
}

variable "test_vm_name" {
  description = "Name of the DR test VM"
  type        = string
}

variable "test_vm_admin_password" {
  description = "Admin password for the DR test VM"
  type        = string
  sensitive   = true
}

variable "bastion_name" {
  description = "Name of the Bastion host"
  type        = string
}

variable "pod_cidr" {
  description = "CIDR range for Kubernetes pods"
  type        = string
}

variable "service_cidr" {
  description = "CIDR range for Kubernetes services"
  type        = string
}

variable "dns_service_ip" {
  description = "IP address of the Kubernetes DNS service (must be within service_cidr)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all DR resources"
  type        = map(string)
  default     = {}
}

