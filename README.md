# zylos-platform-infra

Terraform infrastructure-as-code and base Kubernetes manifests for the Zylos e-commerce platform.

## Repository Structure

- terraform/
    - modules/ # Reusable Terraform modules (vpc, eks, aurora, msk, etc.)
    - environments/ # Per-environment root modules (local, dev, prod)
- kubernetes/
     - base/ # Kustomize bases for cluster-wide resources
     - overlays/ # Per-environment overlays
- scripts/ # Operational helper scripts
- docs/ # Architecture decision records, runbooks

## Prerequisites

- Terraform >= 1.9
- AWS CLI v2
- kubectl
- Helm 3
- An AWS account with sufficient permissions (see `docs/iam-bootstrap.md`)

## Local Development

This repository's Terraform is designed for AWS production deployment.
For local Kubernetes development, see [`zylos-local-env`](https://github.com/zylos-platform/zylos-local-env).

## Deploying to AWS

See `docs/aws-deployment.md` for the full deployment runbook.
**WARNING**: A full deployment incurs ongoing AWS costs.
Tear down with `terraform destroy` when not in use.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).