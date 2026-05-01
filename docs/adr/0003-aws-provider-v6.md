# ADR 0003: AWS Provider v6.x — Adopt the Per-Resource Region Argument

- **Status:** Accepted
- **Date:** 2026-05-01

## Context

AWS Provider v6.0 (GA April 2026) introduces a major workflow change:
resources now accept an inline `region = "us-west-2"` argument, removing
the need for `provider "aws" { alias = "..." }` blocks for cross-region work.

## Decision

Pin to **`hashicorp/aws ~> 6.0`** in every `versions.tf`. Use the new
inline `region` argument when we need cross-region resources rather than
defining provider aliases.

## Rationale

- Substantially less boilerplate for multi-region.
- Single AWS provider config = lower memory and cleaner state.
- Alias-based providers still work, so we can mix where it's clearer.

## Migration Note

Mostly clean for greenfield. Watch for deprecated resource arguments
(documented in HashiCorp's v6 upgrade guide):
- `aws_eip.vpc = true` → `aws_eip.domain = "vpc"`
- All 16 `aws_opsworks_*` resources are removed.
- Boolean strings (`"1"`, `"0"`) are no longer accepted; use `true`/`false`.
