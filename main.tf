terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 0.13"
}

provider "aws" {
  region = var.region
}

data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = var.org
    workspaces = {
      name = var.vpc_workspace
    }
  }
}

resource "aws_security_group" "sg_ingress" {
  name          = "${var.prefix}_foundation_ingress_sg"
  description   = "${var.prefix} Foundational Ingress Security Group"
  vpc_id        = data.terraform_remote_state.vpc.outputs.vpc_id

  # owner cidr blocks
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.owner_cidr_blocks
  }

  # vpc cidr block
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.vpc_cidr_block]
  }

  tags = {
    Name               = "${var.prefix}_foundation_ingress_sg"

    owner              = var.owner
    se-region          = var.se-region
    purpose            = var.purpose
    ttl                = var.ttl
    terraform          = "true"
    hc-internet-facing = var.hc-internet-facing
    creator            = var.creator
    customer           = var.customer
    tfe-workspace      = var.tfe-workspace
    lifecycle-action   = var.lifecycle-action
    config-as-code     = var.config-as-code
    repo               = var.repo
  }
}

resource "aws_security_group" "sg_egress" {

  name          = "${var.prefix}_foundation_egress_sg"
  description   = "${var.prefix} Foundational Egress Security Group"
  vpc_id        = data.terraform_remote_state.vpc.outputs.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name               = "${var.prefix}_foundation_egress_sg"

    owner              = var.owner
    se-region          = var.se-region
    purpose            = var.purpose
    ttl                = var.ttl
    terraform          = "true"
    hc-internet-facing = var.hc-internet-facing
    creator            = var.creator
    customer           = var.customer
    tfe-workspace      = var.tfe-workspace
    lifecycle-action   = var.lifecycle-action
    config-as-code     = var.config-as-code
    repo               = var.repo
  }
}
