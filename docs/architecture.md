# Architecture — How the Pieces Compose

## Repo Boundary

`zylos-platform-infra` provisions **AWS infrastructure**. It does not
deploy applications, install cluster addons, or configure GitOps. Those
live in `zylos-platform-bootstrap` and the service repos.

## Module Composition

```
environments/dev/main.tf
│
├── module "network"            (modules/network)
│       └─ VPC, subnets, NAT, flow logs
│
├── module "eks"                (modules/eks-cluster)
│       └─ EKS control plane + Karpenter
│       └─ depends on: network outputs (vpc_id, subnets)
│
├── module "msk"                (modules/msk)
│       └─ Managed Kafka cluster
│       └─ depends on: network
│
├── module "aurora_postgres"    (modules/aurora-postgres)
│       └─ Aurora cluster (writer + readers)
│       └─ depends on: network
│
├── module "elasticache_redis"  (modules/elasticache-redis)
│       └─ Redis cluster
│       └─ depends on: network
│
└── module "opensearch"         (modules/opensearch)
        └─ OpenSearch managed cluster
        └─ depends on: network
```

## State Organization

- One state file per environment: `<env>/zylos.tfstate`.
- All in the same S3 bucket; isolation via S3 key prefix.
- Locking via S3 native conditional writes.

## Cost Awareness

Every module's `README.md` will state its idle and busy AWS cost. Aggregated
in `docs/runbook-deploy.md`.

## Multi-Region (Future)

Introduces a `prod-eu/` and `prod-ap/` environment. AWS Provider v6
allows us to define cross-region resources in a single config without
provider aliases.
