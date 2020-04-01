#
# Provider Configuration
#

provider "aws" {
  region = "us-east-1"
  alias = "east"
}

# Additional provider configuration for west coast region
provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

module "west" {
  owner = var.owner
  environment = "west"
  region = "us-west-2"
  source = "./datacenter"
  cidr = "10.0.0.0/16"
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  worker_instance_size = var.worker_instance_size
  ssh_key_name = var.ssh_key_name
  // cluster-name = "west-cluster"
  // primary_datacenter = "west-cluster"
  datacenter = "west"
  primary_datacenter = "west"
  consul_address = "10.0.1.100"
  
  providers = {
    aws = aws.west
  }
}
module "east" {
  owner = var.owner
  environment = "east"
  region = "us-east-1"
  source = "./datacenter"
  cidr = "10.1.0.0/16"
  public_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  private_subnets = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]
  worker_instance_size = var.worker_instance_size
  ssh_key_name = var.ssh_key_name
  // cluster-name = "east-cluster"
  // primary_datacenter = "west-cluster"
  datacenter = "east"
  primary_datacenter = "west"
  consul_address = "10.1.1.100"
  
  providers = {
    aws = aws.east
  }
}


