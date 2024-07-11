resource "hcloud_primary_ip" "fsms_instance_ipv4_1" {
  name = "fsms_primary_v4"
  datacenter = var.hcloud_datacenter
  type = "ipv4"
  assignee_type = "server"
  auto_delete = true
}

resource "hcloud_server" "fsms_instance" {
  name = "fsmserver-${var.hcloud_datacenter}"
  image = "ubuntu-24.04"
  datacenter = var.hcloud_datacenter
  server_type = "cx22"
  ssh_keys = var.ssh_keys_to_inject
  public_net {
    ipv4_enabled = true
    ipv4 = hcloud_primary_ip.fsms_instance_ipv4_1.id
    ipv6_enabled = false
  }
}

resource "local_file" "ansible_inventory_file" {
  filename = "hosts"
  content = hcloud_primary_ip.fsms_instance_ipv4_1.ip_address
}
