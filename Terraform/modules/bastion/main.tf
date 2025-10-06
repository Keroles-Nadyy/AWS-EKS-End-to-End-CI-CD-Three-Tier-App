resource "aws_instance" "bastion_instance" {
  ami                    = "ami-0360c520857e3138f"
  instance_type          = "t2.micro"
  subnet_id              = var.subnets_details["public_subnet_I"].id
  vpc_security_group_ids = [var.bastion_sg_id]
  key_name               = aws_key_pair.bastion_key.key_name

  tags = {
    Name = "${var.common_resource_name}_bastion"
  }
}

resource "aws_key_pair" "bastion_key" {
  key_name   = "${var.common_resource_name}_bastion_key"
  public_key = var.public_key
}

resource "aws_cloudwatch_log_group" "bastion" {
  name = "/aws/bastion/${var.common_resource_name}"
}

# data "aws_ami" "ubuntu" {
#   most_recent = true
#   owners      = ["099720109477"]

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#   }
# }