output "tfstate_bucket_name" {
  description = "Name of the S3 bucket created for Terraform state. Use this in other environments' backend.tf files."
  value       = aws_s3_bucket.tfstate.id
}

output "tfstate_bucket_arn" {
  description = "ARN of the Terraform state bucket"
  value       = aws_s3_bucket.tfstate.arn
}

output "aws_region" {
  description = "AWS region where the state bucket lives"
  value       = var.aws_region
}

output "caller_identity" {
  description = "AWS account and IAM identity that created the bootstrap"
  value = {
    account = data.aws_caller_identity.current.account_id
    arn     = data.aws_caller_identity.current.arn
    user_id = data.aws_caller_identity.current.user_id
  }
}
