variable "instances" {
  type = map(object({
    instance_type = string
    key_name      = string
    private_ip    = string
    volume_size   = number
    sg_ids        = list(string)
  }))
}

variable "subnet_id" {
  type = string
}

variable "ami_id" {
  type = string
}