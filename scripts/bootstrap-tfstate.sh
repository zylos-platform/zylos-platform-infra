#!/usr/bin/env bash
#
# bootstrap-tfstate.sh — one-time setup of the S3 bucket for Terraform state.

set -euo pipefail

cd "$(dirname "$0")/.."

ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"
echo "==> Bootstrapping Terraform state bucket for AWS account ${ACCOUNT_ID}"

cd terraform/environments/bootstrap
terraform init
terraform apply -var="account_id=${ACCOUNT_ID}"

BUCKET="$(terraform output -raw tfstate_bucket_name)"
echo ""
echo "✓ Bootstrap complete. State bucket: ${BUCKET}"
echo ""
echo "Next steps:"
echo "  1. Update terraform/environments/dev/backend.tf — replace CHANGEME with: ${BUCKET}"
echo "  2. Update terraform/environments/prod/backend.tf — same."
echo "  3. Commit terraform/environments/bootstrap/terraform.tfstate to Git."
