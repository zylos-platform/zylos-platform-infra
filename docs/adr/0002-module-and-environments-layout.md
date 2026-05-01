# ADR 0002: Module + Environments Layout

- **Status:** Accepted
- **Date:** 2026-05-01

## Context

Several Terraform repository layouts are common: flat, module + environment,
and Terragrunt-driven. Each scales differently.

## Decision

Use **`terraform/modules/` + `terraform/environments/<env>/`**.

- Modules are reusable building blocks: `network`, `eks-cluster`, `msk`, etc.
- Environments are root configurations that compose modules.
- Each environment has its own state file (`<env>/zylos.tfstate`).

## Rationale

- Industry-standard structure (used by AWS-IA EKS Blueprints, gruntwork
  reference architectures, etc.).
- Clean isolation: applying dev never touches prod state.
- Reusable modules avoid duplication across environments.
- Promotes environment parity: prod is just dev with different `tfvars`.

## Alternatives Rejected

- **Flat layout.** Doesn't scale beyond single-environment toy projects.
- **Terragrunt.** Reduces duplication further but introduces a third tool
  and another DSL. Acceptable later if duplication becomes painful; not
  worth the complexity at this stage.
