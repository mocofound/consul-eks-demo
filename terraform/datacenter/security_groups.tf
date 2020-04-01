resource "aws_security_group" "allowed_from_internet" {
  name        = "${local.cluster_name}-allowed-from-internet"
  description = "Traffic Allowed from dirty internet"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // allow ssh 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  // consul http - not safe for prodcution, use HTTPS
  ingress {
    from_port   = 8500
    to_port     = 8500
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // remote dc forwarding
  ingress {
    from_port   = 8300
    to_port     = 8300
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // wan gossip
  ingress {
    from_port   = 8302
    to_port     = 8302
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8302
    to_port     = 8302
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // mesh gateway
  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }      
}


resource "aws_security_group" "allow_local" {
  name        = "${local.cluster_name}-allow-local"
  description = "Traffic Allowed from local VPC"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "allow_local" {
  security_group_id = aws_security_group.allow_local.id
  source_security_group_id = aws_security_group.allow_local.id
  type            = "ingress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  
}
