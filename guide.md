You are cleaning up this Terraform project (directory "AKS Backup") to bring it closer to
industry-standard practice, based on a full project audit. Do NOT change any resource's actual
configuration or behavior — only refactor for maintainability and best practice.
The infrastructure is fully applied and working; nothing here should trigger a resource
recreation/destroy. After every change, run `terraform plan` yourself and confirm it shows "No changes"
(0 to add, 0 to change, 0 to destroy) before moving to the next task — if any task's change would
show a diff in plan, STOP and report it to me instead of applying.

=== TASK 1: Secrets hygiene ===
- Check .gitignore: confirm terraform.tfvars and any *.tfstate* files are excluded. If not, add them.
- Do NOT modify how secrets are currently stored or managed.
- Do NOT add Azure Key Vault, environment variables, TF_VAR variables, or any other secret-management
  mechanism.
- Leave the existing test_vm_admin_password and dr_test_vm_admin_password handling unchanged.

=== TASK 2: Parameterize dr.tf ===
In dr.tf, replace the hardcoded test_vm_name, pod_cidr, service_cidr, dns_service_ip, and tags with
proper variable references. Add the missing variables (dr_test_vm_name, dr_pod_cidr,
dr_service_cidr, dr_dns_service_ip — with defaults matching current hardcoded values so nothing
changes) to variables.tf and terraform.tfvars. For tags, add a root-level `tags` variable (default
matching the current map) and reference it in both dr.tf and anywhere else tags are hardcoded
identically across files, without changing any existing resource's tag values.

=== TASK 3: Fix the misleading variable name ===
Rename nat_public_ip_prefix to nat_public_ip_allocation_method throughout variables.tf,
terraform.tfvars, and nat.tf (do not touch modules/dr-aks, which already hardcodes "Static" and
doesn't have this issue). Update the variable's description to accurately reflect what it does.

=== TASK 4: Clean up stale files ===
Delete validate-err.txt and validate-out.txt if they still exist and are confirmed unused by any
script or CI config.

=== TASK 5: Update README.md ===
Rewrite README.md to reflect the CURRENT full architecture: primary cluster, full backup pipeline
(vault/policy/extension/instance/roles), and the isolated DR module — not just the original pre-backup
infra. Include a simple architecture diagram in text/ASCII form, the file inventory, and a "Current Scope"
section noting that restore is a manual operation, not Terraform-managed.

=== CONSTRAINTS ===
- Run `terraform fmt` and `terraform validate` after all changes.
- Run `terraform plan` after each task and confirm "No changes" — exactly 0 to add, 0 to change,
  0 to destroy — before moving to the next task.
- Do NOT run `terraform apply` for any cleanup/refactoring task.
- If any task produces a Terraform plan diff, STOP immediately and report the diff instead of applying.
- Do NOT modify actual Azure resource configuration or behavior.



=== CONTINUATION NOTE ===
Cline previously started this cleanup but reached its credit limit during TASK 2.
TASK 1 was completed by Cline, and TASK 2 was partially completed. Continue from the
CURRENT project state: first inspect what Cline has already changed, preserve all
correct existing changes, and complete only the remaining work. Do not redo completed
work or revert any existing changes.