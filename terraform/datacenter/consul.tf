data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_iam_role_policy" "consul" {
  name = "${local.cluster_name}-consul-policy"
  role = aws_iam_role.consul.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:DescribeInstances",
        "ec2:DescribeTags",
        "autoscaling:DescribeAutoScalingGroups"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "consul" {
  name = "${local.cluster_name}-consul-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "consul" {
  name = "${local.cluster_name}-instance-prof"
  role = aws_iam_role.consul.name
}

data "template_file" "init" {
  template = "${file("${path.module}/templates/consul.tpl")}"
  vars = {
    consul_address = var.consul_address
    cluster-name = var.datacenter
    primary_datacenter = var.primary_datacenter
  }
}

resource "aws_instance" "consul" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "m5.large"
  private_ip             = var.consul_address
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [
    aws_security_group.allowed_from_internet.id,
    aws_security_group.allow_local.id
  ]
  user_data              = data.template_file.init.rendered
  iam_instance_profile   = aws_iam_instance_profile.consul.name
  key_name               = var.ssh_key_name
  tags = {
    Name = "consul"
    Env  = local.cluster_name
  }
}