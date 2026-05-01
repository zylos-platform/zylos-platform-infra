# elasticache-redis

(Skeleton — not yet implemented.)

## Inputs

See `variables.tf`.

## Outputs

See `outputs.tf`.

## Example Usage

```hcl
module "elasticache-redis" {
  source = "../../modules/elasticache-redis"

  name        = "zylos-dev"
  environment = "dev"
}
```
