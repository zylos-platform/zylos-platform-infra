# ADR 0001: kind for Local Kubernetes (Not minikube, k3d, or Docker Desktop K8s)

- **Status:** Accepted
- **Date:** 2026-05-03

## Context

We need a local Kubernetes cluster for development that closely mirrors AWS
EKS. Several options exist: kind, minikube, k3d, Docker Desktop's built-in
Kubernetes, and microk8s.

## Decision

Use **kind** (Kubernetes IN Docker).

## Rationale

- **Maintained by sig-testing** — kind is the official tool the Kubernetes
  project itself uses for testing. New Kubernetes versions are supported on
  the day of release.
- **Multi-node clusters** — kind can spin up realistic 3-node topologies
  trivially. minikube can too, but the kind workflow is faster.
- **Containerd 2.x** — kind v0.27+ uses containerd 2.x, the same runtime as
  modern EKS nodes.
- **Fast teardown/recreation** — `kind delete cluster` is sub-10-second.
  Critical for the iteration we'll do during development.
- **Image loading** — `kind load docker-image` lets us push locally-built
  service images into the cluster without a registry.
- **CI compatibility** — kind is the standard in GitHub Actions for
  Kubernetes-related testing.

## Trade-offs

- **No native LoadBalancer** — we use NGINX Ingress + extraPortMappings to
  expose services. Documented in cluster.yaml.
- **Storage limited to local volumes** — fine for development.

## Alternatives Rejected

- **minikube:** Slower to start, more "work," historically less aligned with
  upstream Kubernetes test patterns.
- **k3d:** Excellent and lightweight, but uses k3s (a stripped-down k8s
  distribution). We want a "real" upstream Kubernetes for production parity.
- **Docker Desktop's k8s:** A single-node cluster baked into Docker Desktop.
  Limited control, single-node only, harder to tear down without affecting
  Docker.
- **microk8s:** Canonical's option. Fine but less ubiquitous than kind in
  community tutorials.
