# eks-cluster

(Skeleton — not yet implemented.)

## Inputs

See `variables.tf`.

## Outputs

See `outputs.tf`.

## Example Usage

```hcl
module "eks-cluster" {
  source = "../../modules/eks-cluster"

  name        = "zylos-dev"
  environment = "dev"
}
```
