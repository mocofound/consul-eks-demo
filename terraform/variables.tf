variable "prefix" {
  type = string
}
variable "owner" {
  default = "kcorbin"
}

variable "environment" {
  default= "dev"
}

variable "ssh_key_name" {}

variable "worker_instance_size" {
  default = "t2.large"
}