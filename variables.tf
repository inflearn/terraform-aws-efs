variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "prefix" {
  type = string
}

variable "is_backup_enabled" {
  type    = bool
  default = true
}

variable "security_groups" {
  type    = list(string)
  default = null
}

variable "tags" {
  type = map(string)
}
