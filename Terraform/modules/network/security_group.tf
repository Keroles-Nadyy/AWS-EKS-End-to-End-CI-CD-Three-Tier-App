resource "aws_security_group" "eks_cluster_sg" {
  name        = "${var.common_resource_name}-security-group"
  description = "Allow 443 from Jump Server only"

  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // It should be specific IP range
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.common_resource_name}-security-group"
  }
}