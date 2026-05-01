#!/usr/bin/env bash
#
# lint.sh — local pre-commit style check for Terraform code.
# Same checks run in CI.

set -euo pipefail

cd "$(dirname "$0")/.."

echo "==> terraform fmt -check -recursive"
terraform fmt -check -recursive terraform/

echo "==> terraform validate (each environment)"
for env_dir in terraform/environments/*/; do
  echo "    -- $(basename "${env_dir}")"
  (
    cd "${env_dir}"
    # validate works without a backend init when -backend=false is used
    terraform init -backend=false -input=false -no-color > /dev/null
    terraform validate -no-color
  )
done

echo "✓ Lint passed."
