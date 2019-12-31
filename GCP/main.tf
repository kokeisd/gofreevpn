# Create service account key 
# https://console.cloud.google.com/apis/credentials/serviceaccountkey?_ga=2.31998270.-1869427217.1573373711&_gac=1.183459412.1573736032.Cj0KCQiAk7TuBRDQARIsAMRrfUZ90FzjfS7Mq7rX40unbcq-iasumq2qDbh0WyyAMPu2ymHBuMCdGlcaApXKEALw_wcB
# https://www.nebulaworks.com/blog/2019/04/22/simplify-your-gce-instance-bootstrapping-with-terraform/

# List of zones
# https://cloud.google.com/compute/docs/regions-zones/
variable "GCP_SAK_JSON" {}
variable "GCP_PROJ_ID" {}
variable "SSH_PUBKEY" {}
variable "SSH_PVTKEY" {}
variable "GCP_ZONE" {}
variable "GCP_SSH_USER" {}
variable "GCP_VPN_USER" {}


resource "random_string" "number" {
  length  = 4
  upper   = false
  lower   = false
  number  = true
  special = false
}

// Configure the Google Cloud provider
provider "google" {
 credentials = file("${var.GCP_SAK_JSON}")
 project     = "${var.GCP_PROJ_ID}"
}

// A single Google Cloud Engine instance
resource "google_compute_instance" "default" {
 name         = "gofreevpn-${random_string.number.result}"
 machine_type = "f1-micro"
 zone         = "${var.GCP_ZONE}"
 #zone         = "us-west1-a"
  # test firewall config  
  tags = ["openvpn"]

 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-9"
   }
 }


// Make sure flask is installed on all new instances for later steps
 # metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync; pip install flask"

 network_interface {
   network = "default"

   access_config {
     // Include this section to give the VM an external ip address
     #nat_ip = "${google_compute_address.static.address}"
   }
 }

  metadata = {
   ssh-keys = "${var.GCP_SSH_USER}:${file(var.SSH_PUBKEY)}"
  }

  provisioner "file" {
  source      = "../common/bootstrap.sh"
  destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
      inline = [
        "sleep 60",  # dont know why it need to wait for sometime 
        "sudo sed -i 's/nameserver 169.254.169.254/nameserver 8.8.8.8/' /etc/resolv.conf",  # fix dns resolution issue on client
        # "chmod +x /tmp/bootstrap.sh",
        "sudo apt update && sudo apt install dos2unix -y",
        "sudo dos2unix /tmp/bootstrap.sh",
        "sudo bash /tmp/bootstrap.sh ${var.GCP_VPN_USER}",
      ]
    }
  

 connection {
    user = "user1"
    type = "ssh"
    host = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
    private_key = file("${var.SSH_PVTKEY}")
    timeout = "2m"
}

}
output "ip" {
 value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}

