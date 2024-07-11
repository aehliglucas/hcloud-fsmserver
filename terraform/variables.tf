variable "hcloud_token" {
  sensitive = true
}

variable "hcloud_datacenter" {
  description = "ID of the datacenter, which the server should be deployed to"
  default = "nbg1-dc3"
}

variable "ssh_keys_to_inject" {
  type = list
  description = "SSH key names or IDs that should be added to the hcloud server"
  default = []
}

variable "fsms_instances" {
  type = number
}
