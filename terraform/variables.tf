variable "prefix" {
  type = string
}
variable "owner" {
  default = "kcorbin"
}

variable "environment" {
  default= "dev"
}

variable "ssh_key_name" {
  description = "SSH Key must be present in all AWS regions being deployed"
  }

variable "worker_instance_size" {
  default = "m5a.xlarge"
}
