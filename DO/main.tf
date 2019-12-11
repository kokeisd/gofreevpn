variable "SSH_PUBKEY" {}
variable "SSH_PVTKEY" {}
variable "DO_TOKEN" {}
variable "DO_REGION" {}


provider "digitalocean" {
  token = "${var.DO_TOKEN}"
}

resource "random_integer" "default" {
  min     = 1
  max     = 50000
}

resource "random_string" "number" {
  length  = 4
  upper   = false
  lower   = false
  number  = true
  special = false
}


resource "digitalocean_ssh_key" "default" {
  name = "gofreevpn"
  public_key = file("${var.SSH_PUBKEY}")
}


resource "digitalocean_droplet" "gofreevpn" {
    name  = "gofreevpn"
    image = "ubuntu-18-04-x64"
    #region = "nyc1"
    region = "${var.DO_REGION}"
    size   = "512mb"
    ssh_keys = [ "${digitalocean_ssh_key.default.id}" ]

  provisioner "file" {
  source      = "../common/bootstrap.sh"
  destination = "/tmp/bootstrap.sh"
  }

provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo /tmp/bootstrap.sh ${var.GCP_VPN_USER}",
    ]
  }
  connection {
    user = "root"
    type = "ssh"
    host = "${digitalocean_droplet.gofreevpn.ipv4_address}"
    private_key = file("${var.SSH_PVTKEY}")
    timeout = "2m"
  }
}

output "ip" {
    value = "${digitalocean_droplet.gofreevpn.ipv4_address}"
}





