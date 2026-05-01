# zylos-platform-infra

Terraform infrastructure-as-code for the Zylos platform. Provisions AWS
infrastructure (VPC, EKS, MSK, Aurora, ElastiCache, OpenSearch).

## Stack

| Component | Pinned Version |
|-----------|----------------|
| Terraform | `>= 1.10.0` |
| AWS Provider | `~> 6.0` |
| terraform-aws-modules/vpc/aws | `~> 6.0` |
| terraform-aws-modules/eks/aws | `~> 21.0` |
| State Backend | S3 with `use_lockfile = true` (no DynamoDB) |

## Repository Structure

```
│
├── terraform/
│        └─ modules/ # Reusable Terraform modules (vpc, eks, aurora, msk, etc.)
│        └─ environments/ # Per-environment root modules (bootstrap, local, dev, prod)
├── kubernetes/
│        └─ base/ # Kustomize bases for cluster-wide resources
│        └─overlays/ # Per-environment overlays
├── scripts/ # Operational helper scripts
├── docs/ #    Architecture + ADRs + runbooks
```

## Quickstart

### One-time Bootstrap (creates the tfstate S3 bucket)

```bash
make bootstrap
```

### Deploy / Update Dev

```bash
make ENV=dev init
make ENV=dev plan
make ENV=dev apply
```

### Tear Down (cost control)

```bash
make ENV=dev destroy
```

## Local Development

This repository's Terraform is designed for AWS production deployment.
For local Kubernetes development, see [`zylos-local-env`](https://github.com/zylos-platform/zylos-local-env).

## Deploying to AWS

See `docs/aws-deployment.md` for the full deployment runbook.

## Cost Warning

Applying `dev` or `prod` environments creates real AWS resources with
ongoing cost (~$300+/month minimum for `dev`, more for `prod`). Always
`destroy` when not in active use.

## Architecture Decisions

- [ADR 0001: S3 Native Locking](docs/adr/0001-s3-native-locking.md)
- [ADR 0002: Module + Environments Layout](docs/adr/0002-module-and-environments-layout.md)
- [ADR 0003: AWS Provider v6](docs/adr/0003-aws-provider-v6.md)
- [ADR 0004: No Kubernetes Manifests Here](docs/adr/0004-no-local-kubernetes-in-this-repo.md)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). All Terraform changes go through PR;
CI runs `fmt`, `validate`, `tflint`, and `tfsec`
