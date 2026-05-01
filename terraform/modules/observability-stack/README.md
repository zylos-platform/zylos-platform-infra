# observability-stack

(Skeleton — not yet implemented.)

## Inputs

See `variables.tf`.

## Outputs

See `outputs.tf`.

## Example Usage

```hcl
module "observability-stack" {
  source = "../../modules/observability-stack"

  name        = "zylos-dev"
  environment = "dev"
}
```
