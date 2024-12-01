resource "aws_instance" "ec2" {
  ami           = var.ami
  key_name = var.key_pair_name
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = [var.security_group_id]
  associate_public_ip_address = true

  tags = var.instance_tag_names
}