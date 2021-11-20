variable "region" {
  type        = string
  description = "AWS Region in which to provision resources."
  default     = "us-east-1"
}

variable "owner_cidr_blocks" {
  type        = list(string)
  description = "Owner CIDR block to allow access from owner's subnet."
}

variable "prefix" {
  type        = string
  description = "Naming prefix"
}

variable "org" {
  type        = string
  description = "Terraform Cloud/Enterprise Organization Name"
}

variable "foundation_workspace" {
  type        = string
  description = "Name of workspace where VPC was created."
}