variable "ssh_key_name" {}
variable "owner" {}
variable "environment" {}

variable "region" {
  default = "us-west-2"
}

variable "cidr" {
  default = "172.16.0.0/16"
}

variable "private_subnets" {
  default = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
}

variable "public_subnets" {
  default = ["172.16.4.0/24", "172.16.5.0/24", "172.16.6.0/24"]
}

variable "datacenter" {
  default = "dc1"
}

variable "primary_datacenter" {
  default = "dc1"
}

variable "consul_address" {
  default = "172.16.4.100"
}

variable "worker_instance_size" {
  default = "m5a.xlarge"
}