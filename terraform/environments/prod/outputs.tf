output "aws_region" {
  description = "AWS region this environment is deployed to"
  value       = var.aws_region
}

output "aws_account_id" {
  description = "AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}

# Module outputs will be added here as modules are wired up.
