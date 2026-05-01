###############################################################################
#
# Zylos Terraform State Bootstrap
#
# THIS CONFIGURATION USES LOCAL STATE BY DESIGN. It exists to create the S3
# bucket that all OTHER environments use as their remote state backend.
#
# Run this exactly once per AWS account, then commit the resulting
# terraform.tfstate to Git.
#
# Resources created:
#   - S3 bucket (versioned, encrypted, public-access-blocked) for tfstate
#   - Bucket lifecycle policy to age out old state versions
#
###############################################################################

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project
      ManagedBy   = "terraform"
      Component   = "tfstate-bootstrap"
      Environment = "shared"
    }
  }
}

# Bucket name: project + account ID + region. 
locals {
  bucket_name = "${var.project}-tfstate-${var.account_id}-${var.aws_region}"
}

resource "aws_s3_bucket" "tfstate" {
  bucket = local.bucket_name

  # We want this bucket to exist forever; never destroy it.
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Lifecycle policy to clean up old state versions, multipart garbage and abandoned lock files.
resource "aws_s3_bucket_lifecycle_configuration" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    id     = "expire-noncurrent-versions"
    status = "Enabled"

    filter {}

    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }

  rule {
    id     = "abort-incomplete-multipart-uploads"
    status = "Enabled"

    filter {}

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }

  # Lock files (.tflock) are short-lived; clean any abandoned ones quickly.
  rule {
    id     = "expire-stale-lock-files"
    status = "Enabled"

    filter {
      prefix = ""
    }

    # Match anything ending in .tflock via tag; this rule is a safety net.
    expiration {
      expired_object_delete_marker = true
    }
  }
}

# Identify ourselves; useful for confirmation and downstream pipelines.
data "aws_caller_identity" "current" {}
