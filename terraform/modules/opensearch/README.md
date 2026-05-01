# opensearch

(Skeleton — not yet implemented.)

## Inputs

See `variables.tf`.

## Outputs

See `outputs.tf`.

## Example Usage

```hcl
module "opensearch" {
  source = "../../modules/opensearch"

  name        = "zylos-dev"
  environment = "dev"
}
```
