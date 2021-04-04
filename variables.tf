variable "region" {
  type        = string
  description = "AWS Region in which to provision resources."
  default     = "us-west-2"
}

variable "owner_cidr_blocks" {
  type        = list(string)
  description = "Owner CIDR block to allow access from owner's subnet."
}
