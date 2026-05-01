variable "aws_region" {
  description = "Primary AWS region for the dev environment"
  type        = string
  default     = "us-east-1"
}

variable "project" {
  description = "Project name; used for naming and tagging"
  type        = string
  default     = "zylos"
}

variable "environment" {
  description = "Environment identifier"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.10.0.0/16"
}

variable "kubernetes_version" {
  description = "Kubernetes minor version for EKS"
  type        = string
  default     = "1.33"
}

variable "domain_name" {
  description = "DNS domain (e.g., zylos.app) used for Route 53 hosted zones"
  type        = string
  default     = "zylos.app"
}
