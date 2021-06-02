
variable "projects" {
  type = map
  description = "Projects and their IDs"
  default = {}
}

variable "vm_nodes" {
  type = map
  default = {}
}

variable "ssh_user" {
  type = string
  default = ""
}

variable "ssh_password" {
  type = string
  default = ""
}

variable "playbook" {
  type = string
  default = ""
}

variable "ssh_key_public" {
  type = string
  default = ""
}

variable "ssh_key_private" {
  type = string
  default = ""
}

variable "vm_types" {
  type = map
  default = {}
}