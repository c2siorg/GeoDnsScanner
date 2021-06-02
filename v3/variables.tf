
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

variable "ZDNS_script_local"{
  type = string
  default = ""
}
variable "seed_file"{
  type = string
  default = ""
}
variable "cloud_storage_bucket_results_dir"{
  type = string
  default = ""
}
variable "cloud_storage_bucket_logs_dir"{
  type = string
  default = ""
}