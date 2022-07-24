variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "name" {
  type = string
}

variable "encrypted" {
  type    = bool
  default = false
}

variable "enable_backup" {
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

variable "access_points" {
  type    = any
  default = []
}
