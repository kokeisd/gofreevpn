# variable "token" {
#   description = "DO Token"
#   default = "6147998f3dbf1f8163864685359dcceb094658e03ed038336cf98d50a70c7c28"
# }

#variable "sshkey" {
#  default = "E:/.ssh/dovpn_id_rsa.pub"
#}
 
# variable "pvt_key" {
#   default = "E:/.ssh/id_rsa"
# }
# variable "pvt_key" {
#    default = "E:/.ssh/dovpn_id_rsa"
# 
# }

variable "script_path" {
  type        = "string"
  description = "Where is the path to the script locally on the machine?"
  default ="../common/bootstrap.sh"
}

### Region
variable "do_ams2" {
  description = "Digital Ocean Amsterdam Data Center 2"
  default     = "ams2"
}


variable "do_ams3" {
  description = "Digital Ocean Amsterdam Data Center 3"
  default     = "ams3"
}

variable "do_blr1" {
  description = "Digital Ocean Bangalore Data Center 1"
  default     = "blr1"
}

variable "do_fra1" {
  description = "Digital Ocean Frankfurt Data Center 1"
  default     = "fra1"
}

variable "do_lon1" {
  description = "Digital Ocean London Data Center 1"
  default     = "lon1"
}

variable "do_nyc1" {
  description = "Digital Ocean New York Data Center 1"
  default     = "nyc1"
}

variable "do_nyc2" {
  description = "Digital Ocean New York Data Center 2"
  default     = "nyc2"
}

variable "do_nyc3" {
  description = "Digital Ocean New York Data Center 3"
  default     = "nyc3"
}

variable "do_sfo1" {
  description = "Digital Ocean San Francisco Data Center 1"
  default     = "sfo1"
}

variable "do_sgp1" {
  description = "Digital Ocean Singapore Data Center 1"
  default     = "sgp1"
}

variable "do_tor1" {
  description = "Digital Ocean Toronto Datacenter 1"
  default     = "tor1"
}

### OS

variable "ubuntu" {
  description = "Default LTS"
  default     = "ubuntu-16-04-x64"
}

variable "centos" {
  description = "Default Centos"
  default     = "centos-72-x64"
}

variable "coreos" {
  description = "Defaut Coreos"
  default     = "coreos-899.17.0"
}