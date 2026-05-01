# Dev Environment

Single-region deployment of Zylos for development and demos.
Region: `us-east-1`. CIDR: `10.10.0.0/16`. Cluster K8s: `1.33`.

## Prerequisites

1. Bootstrap environment applied (creates the tfstate S3 bucket).
2. AWS credentials configured (`aws sts get-caller-identity` works).
3. `backend.tf` has the correct bucket name (replace `CHANGEME`).

## First-Time Setup

```bash
cd terraform/environments/dev
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars if needed
terraform init
terraform plan
terraform apply
```

## Tear Down (Cost Control)

```bash
terraform destroy
```

The S3 state bucket itself is preserved (it's in `bootstrap/`).

## What's In This Environment

Currently a skeleton. Modules will be wired here as they're implemented.
See [`terraform/modules/`](../../modules) and the project roadmap.
