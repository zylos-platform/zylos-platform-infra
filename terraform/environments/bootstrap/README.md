# Bootstrap Environment

Creates the S3 bucket that every other Zylos environment uses as its
Terraform state backend.

## Run Once, Per AWS Account

```bash
cd terraform/environments/bootstrap
terraform init
terraform apply -var="account_id=$(aws sts get-caller-identity --query Account --output text)"
```

After successful apply, **commit `terraform.tfstate` to Git**. Yes, really.
This file contains no secrets just bucket name, ARN, and tags and serves
as the record of bootstrap configuration.

## Outputs You'll Need

The output `tfstate_bucket_name` is the value you put into every other
environment's `backend.tf`:

```hcl
terraform {
  backend "s3" {
    bucket       = "zylos-tfstate-123456789012-us-east-1"
    key          = "dev/zylos.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
```

## Never Destroy

The S3 bucket has `prevent_destroy = true`. If you genuinely need to recreate
it, remove that lifecycle rule, plan the destroy, and remember that ALL
remote state in the bucket will be lost.
