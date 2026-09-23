# AKS Backup

This Terraform project provisions a private primary Azure Kubernetes Service (AKS) cluster, its Azure
Kubernetes backup pipeline, and an isolated disaster-recovery (DR) AKS environment. The configuration
uses the AzureRM provider and is intended to manage infrastructure prerequisites without changing the
application workloads running on either cluster.

## Architecture

```text
                                  +-----------------------------+
                                  | Azure Data Protection Vault |
                                  |   backup policy + instance  |
                                  +--------------+--------------+
                                                 |
                                      trusted access + Reader
                                                 |
+----------------------+       backup       +---v------------------+
| Primary AKS cluster  |------------------->| Snapshot resource RG |
| aks-lab (private)    |                    +----------------------+
| CNI Overlay + NAT    |
+----------+-----------+
           |
           | Backup extension
           | (blob backup location)
           v
   +---------------------+       restore prerequisites       +------------------+
   | Storage account      |<----------------------------------| Isolated DR AKS  |
   | + blob container     |                                   | aks-lab-dr       |
   +---------------------+                                   | private + NAT    |
                                                               +------------------+
```

### Primary cluster

The primary environment is deployed in `rg-aks-lab` in `East US`:

- Private cluster `aks-lab` with Azure CNI Overlay networking.
- VNet `vnet-aks-lab` (`10.10.0.0/16`) and AKS subnet `snet-aks`
  (`10.10.0.0/22`).
- System and application node pools, both attached to the AKS subnet.
- Standard NAT Gateway with static public IP for controlled outbound access.
- Linux test VM `vm-aks-test` for private-network connectivity testing.

### Backup pipeline

The primary cluster's backup flow is composed of:

1. A dedicated snapshot resource group.
2. A storage account and blob container for backup extension data.
3. An Azure Data Protection backup vault.
4. A Kubernetes backup policy with the configured schedule and retention.
5. The Azure Kubernetes backup extension and trusted-access binding on the primary cluster.
6. A backup instance selecting the namespaces and volume snapshot behavior.
7. Role assignments granting the vault, cluster identity, and extension the permissions required
   for backup operations.

### DR environment

The DR environment is isolated in `rg-aks-lab-dr` with its own VNet, AKS subnet, NAT Gateway,
private AKS cluster, Bastion host, and Linux test VM. The `modules/dr-aks` module owns those
DR infrastructure resources. Root-level DR resources add the backup extension, trusted access,
and role assignments required for a future restore.

## Current Scope

Terraform manages the infrastructure and backup/restore prerequisites described above. The actual
backup restore operation is a **manual operation**, performed through the Azure Portal or Azure CLI;
it is not triggered or managed by Terraform because the AzureRM provider does not expose a restore
operation resource. Kubernetes workloads and post-restore application validation are also outside
the Terraform scope.

## File inventory

| Path | Purpose |
|---|---|
| `providers.tf` | Terraform and AzureRM provider requirements |
| `variables.tf` | Root input variable declarations and defaults |
| `terraform.tfvars` | Deployment-specific input values |
| `resource-group.tf` | Primary resource groups |
| `network.tf` | Primary VNet and AKS subnet |
| `nat.tf` | Primary NAT Gateway and public IP |
| `aks.tf` | Primary private AKS cluster and system node pool |
| `node-pool.tf` | Primary application node pool |
| `vm.tf` | Primary Linux test VM |
| `backup-resource-group.tf` | Backup snapshot resource group |
| `backup-storage.tf` | Backup storage account and blob container |
| `backup-vault.tf` | Azure Data Protection backup vault |
| `backup-policy.tf` | AKS backup policy |
| `aks-backup-extension.tf` | Primary backup extension and trusted access |
| `backup-instance.tf` | Primary AKS backup instance |
| `backup-role-assignments.tf` | Primary backup identity permissions |
| `dr.tf` | Root module call for the isolated DR environment |
| `dr-backup-trusted-access.tf` | DR trusted access and vault permissions |
| `dr-restore-prerequisites.tf` | DR backup extension and restore permissions |
| `modules/dr-aks/` | Reusable DR VNet, AKS, NAT, Bastion, and VM resources |
| `outputs.tf` | Terraform outputs |
| `.gitignore` | Local Terraform artifacts and variable/state exclusions |
| `.terraform.lock.hcl` | Provider dependency lock file |
| `restoreconfig.json` | Restore request configuration reference |
| `restorerequestobject.json` | Restore request object reference |

## Prerequisites

- Terraform 1.6 or later.
- Azure CLI authenticated to the target subscription.
- An Azure subscription with permissions to manage AKS, networking, storage, Azure Data Protection,
  managed identities, and role assignments.

```powershell
az login
az account set --subscription "<SUBSCRIPTION_ID_OR_NAME>"
```

## Usage

Run from the repository root:

```powershell
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

Review the plan before applying. Because the AKS clusters are private, Kubernetes access requires
connectivity from the test VM or another connected private network.

```powershell
az aks get-credentials `
  --resource-group rg-aks-lab `
  --name aks-lab
kubectl get nodes
```

To inspect outputs:

```powershell
terraform output
```

Never manually edit `terraform.tfstate`; Terraform uses it to track the deployed infrastructure.
