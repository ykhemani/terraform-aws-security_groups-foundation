variable region {
  type        = string
  description = "AWS Region in which to provision resources."
  default     = "us-west-2"
}

variable tag_owner {
  type        = string
  description = "Label to identify owner, will be used for tagging resources that are provisioned."
}

variable tag_ttl {
  type        = string
  description = "TTL (in hours) for resources created with this Terraform configuration"
  default     = "24"
}

variable owner_cidr_blocks {
  type        = list(string)
  description = "Owner CIDR block to allow access from owner's subnet."
}
