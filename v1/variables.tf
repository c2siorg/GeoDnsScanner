
variable "projects" {
  type = map
  description = "Projects and their IDs"
  default = {}
}

variable "SSH_usernames" {

  type = map
  description = "SSH Usernames"
  default = {}
}


variable "vm_nodes" {
  type = map
  default = {}
}

variable "SSH_user" {
  type = string
  default = ""
}

variable "playbook" {
  type = string
  default = ""
}