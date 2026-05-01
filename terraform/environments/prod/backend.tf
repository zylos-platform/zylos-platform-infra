###############################################################################
#
# Remote state backend for the `prod` environment.
#
# IMPORTANT:
#   - The S3 bucket MUST exist (run terraform/environments/bootstrap first).
#   - Replace the bucket name below with the value output by bootstrap.
#   - DO NOT commit secrets here; this file only references infrastructure
#     identifiers.
#
# Locking:
#   We use Terraform's native S3 locking. No DynamoDB table is needed.
#
###############################################################################
terraform {
  backend "s3" {
    # NOTE: bucket name is templated for documentation; replace it in your
    # local copy or pass via `terraform init -backend-config="bucket=..."`.
    bucket       = "zylos-tfstate-CHANGEME-us-east-1"
    key          = "prod/zylos.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
