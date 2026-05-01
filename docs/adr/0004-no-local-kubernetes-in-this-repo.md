# ADR 0004: No Local Kubernetes Tooling in `zylos-platform-infra`

- **Status:** Accepted
- **Date:** 2026-05-01

## Context

It's tempting to put Kubernetes manifests (Istio installation, Argo CD
installation, namespace definitions) into the same repo as Terraform.

## Decision

`zylos-platform-infra` owns **AWS infrastructure only**. Kubernetes-side
manifests live in `zylos-platform-bootstrap` (Argo CD GitOps) and the
individual service repos.

## Rationale

- **Clear separation of concerns.** Terraform provisions the cluster;
  GitOps deploys workloads to the cluster. Mixing both makes the boundary
  fuzzy and tempts engineers to reach across the line.
- **Different cadence.** Infra changes monthly; cluster manifest changes
  daily.
- **Different tooling.** Terraform vs. Kustomize/Helm/Argo CD.
- **Different blast radius.** A bad Terraform apply can delete the cluster;
  a bad manifest only affects one workload.

## Implication

The `kubernetes/` folder in this repo is empty by design and will likely
stay that way. It exists to make the boundary explicit, not to be filled.
