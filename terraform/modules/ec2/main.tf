resource "aws_instance" "this" {
  for_each = var.instances

  ami                         = var.ami_id
  instance_type               = each.value.instance_type
  key_name                    = each.value.key_name
  subnet_id                   = var.subnet_id
  private_ip                  = each.value.private_ip
  associate_public_ip_address = true
  vpc_security_group_ids      = each.value.sg_ids

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    volume_size = each.value.volume_size
    volume_type = "gp3"
  }

  tags = {
    Name = each.key
  }
}