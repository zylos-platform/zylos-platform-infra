# network

(Skeleton — not yet implemented.)

## Inputs

See `variables.tf`.

## Outputs

See `outputs.tf`.

## Example Usage

```hcl
module "network" {
  source = "../../modules/network"

  name        = "zylos-dev"
  environment = "dev"
}
```
