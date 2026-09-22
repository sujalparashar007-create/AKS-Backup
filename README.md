# Private AKS Infrastructure with Terraform

This repository provisions a private Azure Kubernetes Service (AKS) cluster with Azure CNI Overlay networking, dedicated node pools, private subnet networking, NAT Gateway-based outbound connectivity, and a Linux test virtual machine.

All infrastructure is managed through Terraform using the AzureRM provider.

## Architecture

The deployment contains the following components:

- Azure Resource Group: `rg-aks-lab`
- Azure region: `East US`
- Virtual Network: `vnet-aks-lab`
- VNet address space: `10.10.0.0/16`
- AKS subnet: `snet-aks`
- AKS subnet address range: `10.10.0.0/22`
- Private AKS cluster: `aks-lab`
- AKS DNS prefix: `akslab`
- System node pool: `system`
- User/application node pool: `apps`
- NAT Gateway: `nat-aks-lab`
- Static NAT public IP: `pip-nat-aks-lab`
- Linux test VM: `vm-aks-test`

## Networking

The AKS cluster is configured with:

- Azure CNI networking.
- Azure CNI Overlay mode.
- IPv4 networking.
- Pod CIDR: `10.244.0.0/16`.
- Service CIDR: `10.0.0.0/16`.
- DNS service IP: `10.0.0.10`.
- Private AKS cluster access.
- User-assigned NAT Gateway outbound traffic.
- No public IPs enabled on the AKS nodes.

The system node pool and user node pool both use the existing AKS subnet. In Azure CNI Overlay mode, pod addresses are allocated from the overlay pod CIDR rather than from additional IP addresses in the Azure VNet subnet.

## Node Pools

### System node pool

- Name: `system`
- VM size: `Standard_D2alds_v7`
- Initial node count: `1`
- Autoscaling range: `1` to `3` nodes
- Upgrade surge: `10%`
- Subnet: `snet-aks`

### User/application node pool

- Name: `apps`
- Mode: `User`
- VM size: `Standard_D2alds_v7`
- Initial node count: `1`
- Autoscaling range: `1` to `5` nodes
- Upgrade surge: `10%`
- Subnet: `snet-aks`

## NAT Gateway and Outbound Access

The deployment creates a Standard NAT Gateway with a static Standard public IP address. The public IP is associated with the NAT Gateway, and the NAT Gateway is associated with the AKS subnet.

The AKS cluster is configured with:

```hcl
outbound_type = "userAssignedNATGateway"
```

This provides controlled outbound connectivity for resources using the AKS subnet while the AKS control plane remains private.

## Test Virtual Machine

The repository provisions a Linux test VM for private AKS and network testing:

- Name: `vm-aks-test`
- Image: Ubuntu 24.04 LTS
- VM size: `Standard_D2alds_v7`
- Network interface: `nic-aks-test`
- Network placement: AKS subnet
- OS disk: Standard LRS
- Private IP output: `aks_test_vm_private_ip`

The VM uses the `test_vm_admin_password` Terraform variable for administrator access.

## Repository Files

| File | Purpose |
|---|---|
| `providers.tf` | Terraform and AzureRM provider requirements |
| `variables.tf` | Input variable declarations |
| `terraform.tfvars` | Deployment-specific variable values |
| `resource-group.tf` | Azure resource group |
| `network.tf` | Virtual network and AKS subnet |
| `nat.tf` | NAT Gateway, public IP, and subnet associations |
| `aks.tf` | Private AKS cluster and system node pool |
| `node-pool.tf` | User/application node pool |
| `vm.tf` | Linux test VM and network interface |
| `outputs.tf` | Deployment outputs |
| `.terraform.lock.hcl` | Locked AzureRM provider checksums and version |
| `terraform.tfstate` | Terraform-managed infrastructure state |
| `terraform.tfstate.backup` | Terraform state backup |

## Prerequisites

Install and authenticate the following tools before deployment:

- Terraform `1.6.0` or later.
- Azure CLI.
- An Azure subscription with permissions to create and manage the configured resources.
- Access to an Azure region that supports the selected VM size and AKS configuration.

Authenticate with Azure:

```powershell
az login
az account set --subscription "<SUBSCRIPTION_ID_OR_NAME>"
```

## Configuration

Deployment values are stored in `terraform.tfvars`. The configuration includes:

- Resource group and region.
- VNet and subnet names.
- VNet and subnet address ranges.
- AKS cluster name and DNS prefix.
- NAT Gateway and public IP names.
- NAT Gateway settings.
- Test VM administrator password.

Do not commit real passwords, credentials, kubeconfig files, or state files to a public repository. Use a protected variable file, environment variables, or a secrets-management system for sensitive values.

## Deploying the Infrastructure

Run the following commands from this directory:

```powershell
terraform init
terraform validate
terraform plan
terraform apply
```

Review the plan carefully before confirming `terraform apply`.

Display the configured outputs:

```powershell
terraform output
```

Display the test VM private IP:

```powershell
terraform output aks_test_vm_private_ip
```

## AKS Access

Because this is a private AKS cluster, access to the private API server requires network connectivity from an approved network path, such as the test VM or another connected private network.

After connecting to a machine with private network access, retrieve the AKS credentials with:

```powershell
az aks get-credentials `
  --resource-group rg-aks-lab `
  --name aks-lab
```

Verify cluster access:

```powershell
kubectl get nodes
kubectl get pods --all-namespaces
```

## Updating the Infrastructure

After changing Terraform configuration or input values:

```powershell
terraform fmt
terraform validate
terraform plan
terraform apply
```

Do not manually edit `terraform.tfstate`. Terraform uses this file to track deployed resources.

## Destroying the Infrastructure

To remove all resources managed by this Terraform configuration:

```powershell
terraform destroy
```

This operation is destructive. Review the proposed destroy plan carefully before confirming it.

## Current Scope

This repository provisions Azure infrastructure only. It does not currently contain:

- Kubernetes workload manifests.
- Application deployments.
- Services or ingress resources.
- Container registry resources.
- CI/CD pipeline definitions.
- Monitoring, logging, or alerting resources.
