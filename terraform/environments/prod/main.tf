###############################################################################
#
# Zylos Prod Environment Root Module
#
# This file composes the reusable modules under terraform/modules/* into a
# working Prod environment.
#
# Currently a SKELETON. Modules will be added in future commits. Example modules:
#   - Network module
#   - EKS cluster module
#   - MSK / Aurora / etc.
#
###############################################################################

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.common_tags
  }
}

locals {
  name_prefix = "${var.project}-${var.environment}"

  common_tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
    Repository  = "zylos-platform-infra"
  }
}

# Identity & region awareness
data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "aws_region" "current" {}

###############################################################################
# Modules will be wired here as they are built.
#
# Example:
#
#   module "network" {
#     source = "../../modules/network"
#
#     name        = local.name_prefix
#     vpc_cidr    = var.vpc_cidr
#     environment = var.environment
#   }
#
#   module "eks" {
#     source = "../../modules/eks-cluster"
#
#     name               = local.name_prefix
#     kubernetes_version = var.kubernetes_version
#     vpc_id             = module.network.vpc_id
#     subnet_ids         = module.network.private_subnet_ids
#     environment        = var.environment
#   }
#
###############################################################################
