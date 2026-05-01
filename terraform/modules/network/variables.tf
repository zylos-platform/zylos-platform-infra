variable "name" {
  description = "Resource name prefix for all resources created by this module"
  type        = string
}

variable "environment" {
  description = "Environment identifier (dev, prod, etc.)"
  type        = string
}

variable "tags" {
  description = "Additional tags to apply on top of the inherited default_tags"
  type        = map(string)
  default     = {}
}
