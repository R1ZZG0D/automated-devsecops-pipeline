output "instance_ids" {
  value = {
    for k, v in aws_instance.this :
    k => v.id
  }
}