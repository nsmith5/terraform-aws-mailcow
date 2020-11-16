variable "key_name" {
  description = "Name of EC2 key pair to add to instance"
  default     = null
}

variable "conf" {
  description = "mailcow.conf file"
  default     = null
}
