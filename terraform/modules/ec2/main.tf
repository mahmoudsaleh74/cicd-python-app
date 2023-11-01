data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "instance" {
  ami           = data.aws_ami.ubuntu.id
  key_name      = var.key_pair_name
  instance_type = var.instance_type
  availability_zone=var.availability_zone
  subnet_id=var.subnet_id
  vpc_security_group_ids=[var.sg]
  associate_public_ip_address= true
  iam_instance_profile = var.eks_profile_name

  root_block_device {
    volume_size           = var.volume_size
    volume_type           = var.volume_type
    encrypted             = true
    delete_on_termination = true
  }
  tags = {
    Name = var.instance_name
  }

}
