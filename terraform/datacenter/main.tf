terraform {
  required_version = ">= 0.12.6"
}

locals {
  cluster_name = "${var.owner}-${var.environment}-${lower(random_string.suffix.result)}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.6"

  name                 = local.cluster_name
  cidr                 = var.cidr
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

    public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }

}


module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_version = "1.14" 
  vpc_id = module.vpc.vpc_id
  cluster_name = local.cluster_name
  subnets      = module.vpc.private_subnets
  config_output_path = "../"
  kubeconfig_name = "kubeconfig_${var.datacenter}"
  worker_additional_security_group_ids = [aws_security_group.allow_local.id]
  tags = {
    Owner = var.owner
    Environment = "test"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }

  manage_aws_auth  = true
  write_kubeconfig = true

  worker_groups = [
    {
      instance_type        = var.worker_instance_size
      asg_max_size         = 3
      asg_desired_capacity = 3
    }
  ]
}
