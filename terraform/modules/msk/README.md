# msk

(Skeleton — not yet implemented.)

## Inputs

See `variables.tf`.

## Outputs

See `outputs.tf`.

## Example Usage

```hcl
module "msk" {
  source = "../../modules/msk"

  name        = "zylos-dev"
  environment = "dev"
}
```
