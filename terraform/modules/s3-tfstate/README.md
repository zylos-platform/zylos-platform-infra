# s3-tfstate

(Skeleton — not yet implemented.)

## Inputs

See `variables.tf`.

## Outputs

See `outputs.tf`.

## Example Usage

```hcl
module "s3-tfstate" {
  source = "../../modules/s3-tfstate"

  name        = "zylos-dev"
  environment = "dev"
}
```
