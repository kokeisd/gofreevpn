# Test the firewall setup




resource "google_compute_firewall" "default" {
 name    = "openvpn-firewall"
 network = "default"

 allow {
   protocol = "tcp"
 }

 allow {
   protocol = "tcp"
   ports    = ["1194"]
 }

 source_ranges = ["0.0.0.0/0"]
 target_tags = ["openvpn"]
}