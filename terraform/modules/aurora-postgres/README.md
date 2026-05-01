# aurora-postgres

(Skeleton — not yet implemented.)

## Inputs

See `variables.tf`.

## Outputs

See `outputs.tf`.

## Example Usage

```hcl
module "aurora-postgres" {
  source = "../../modules/aurora-postgres"

  name        = "zylos-dev"
  environment = "dev"
}
```
