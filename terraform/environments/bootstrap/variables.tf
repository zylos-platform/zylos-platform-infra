variable "aws_region" {
  description = "AWS region for the Terraform state bucket"
  type        = string
  default     = "us-east-1"
}

variable "project" {
  description = "Project name; used for resource naming and tagging"
  type        = string
  default     = "zylos"
}

variable "account_id" {
  description = "AWS account ID. Used to compose the bucket name to avoid global-name collisions."
  type        = string
}
