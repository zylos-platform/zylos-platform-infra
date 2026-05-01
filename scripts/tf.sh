#!/usr/bin/env bash
#
# tf.sh — convenience wrapper for running Terraform against an environment.
#
# Usage:
#   ./scripts/tf.sh <env> <terraform-command> [args...]
#
# Examples:
#   ./scripts/tf.sh dev init
#   ./scripts/tf.sh dev plan
#   ./scripts/tf.sh dev apply
#   ./scripts/tf.sh bootstrap apply -var="account_id=$(aws sts get-caller-identity --query Account --output text)"

set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <env> <terraform-command> [args...]" >&2
  exit 2
fi

ENV="$1"
shift
ENV_DIR="$(dirname "$0")/../terraform/environments/${ENV}"

if [[ ! -d "${ENV_DIR}" ]]; then
  echo "ERROR: environment '${ENV}' not found at ${ENV_DIR}" >&2
  exit 1
fi

cd "${ENV_DIR}"
terraform "$@"
