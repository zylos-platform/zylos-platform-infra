# kind — Local Kubernetes Cluster

This directory holds the configuration for the local Kubernetes cluster that
runs on a developer's machine via [kind](https://kind.sigs.k8s.io/).

## Configurations

| File                | Use                                                                               |
| ------------------- | --------------------------------------------------------------------------------- |
| `cluster.yaml`      | **Default.** 3-node cluster (1 control plane + 2 workers). Closest to production. |
| `cluster-lean.yaml` | Single-node cluster. Use when RAM-constrained.                                    |

## Prerequisites

- Docker Desktop (with WSL2 integration on Windows).
- `kind` v0.31.0+ installed.
- `kubectl` installed.
- At least **8 GB of free RAM** for the lean config; **12 GB** for the default config.

## Create the Cluster

```bash
# Default (3-node)
kind create cluster --config kubernetes/kind/cluster.yaml

# Lean (1-node)
kind create cluster --config kubernetes/kind/cluster-lean.yaml
```

The cluster takes ~2 minutes to come up. `kubectl config current-context` will
switch to `kind-zylos` automatically.

## Install NGINX Ingress

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.3/deploy/static/provider/kind/deploy.yaml

# Wait for it to be ready
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=180s
```

After this, ports 80 and 443 on `localhost` route into the cluster.

## Bootstrap the Platform

Now hand off to the GitOps bootstrap:

```bash
cd ../zylos-platform-bootstrap
make bootstrap
```

## Tear Down

```bash
kind delete cluster --name zylos
```

This is fast and reclaims all memory. Use it freely between work
sessions.

## Architecture Decisions

- [ADR 0001: kind for local Kubernetes](adr/0001-kind-for-local-k8s.md)
