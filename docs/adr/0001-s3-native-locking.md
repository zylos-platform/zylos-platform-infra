# ADR 0001: S3 Native State Locking (No DynamoDB)

- **Status:** Accepted
- **Date:** 2026-05-01
- **Deciders:** Kamesh Chathuranga

## Context

Terraform state stored in S3 historically required a separate DynamoDB
table for locking (to prevent concurrent state mutation). DynamoDB locking
is a real cost and an extra resource to manage.

In Terraform 1.10 (late 2024) and stabilized in 1.11, the S3 backend gained
**native state locking** using S3 conditional writes. As of HashiConf 2025,
DynamoDB locking is **officially deprecated** and slated for removal.

## Decision

We use **S3 native locking** (`use_lockfile = true`) exclusively. Zylos
will **never create a DynamoDB lock table**.

## Rationale

- One less AWS resource to provision, IAM-permission, monitor, and pay for.
- Officially the modern path; DynamoDB-based locking is on the deprecation
  track.
- Same correctness guarantees: S3 conditional writes are atomic.
- Simpler IAM: only S3 permissions needed on the state bucket.

## Trade-offs Accepted

- Requires Terraform `>= 1.10`. We pin this in every `versions.tf`.

## Implementation

In every environment's `backend.tf`:

    terraform {
      backend "s3" {
        bucket       = "zylos-tfstate-..."
        key          = "<env>/zylos.tfstate"
        region       = "us-east-1"
        encrypt      = true
        use_lockfile = true
      }
    }
