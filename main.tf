data terraform_remote_state vpc {
  backend = "remote"

  config = {
    organization = "khemani"
    workspaces = {
      name = "terraform-aws-vpc-se_demos_dev-us_west_2"
    }
  }
}

resource aws_security_group sg_ingress {
  name          = "${var.tag_owner}_foundation_ingress_sg"
  description   = "${var.tag_owner} Foundational Ingress Security Group"
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
    Owner = var.tag_owner
    Name  = "${var.tag_owner}_foundation_ingress_sg"
  }
}

resource aws_security_group sg_egress {

  name          = "${var.tag_owner}_foundation_egress_sg"
  description   = "${var.tag_owner} Foundational Egress Security Group"
  vpc_id        = data.terraform_remote_state.vpc.outputs.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Owner = var.tag_owner
    Name  = "${var.tag_owner}_foundation_egress_sg"
  }
}
