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

variable "nat_public_ip_prefix" {
  description = "Allocation method for NAT Gateway public IP"
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