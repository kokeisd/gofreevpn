# gofreevpn
# Why

There are a number of good reasons why people would like to use VPN to secure their online traffic or prevent their real IP address from being identified by the other side of commnuication. For example, some online shopping or video streamming services only provide services to certain regions(based on your IP address). Or in some situations where you can visit a website directly because of firewall or DNS restrictions.

In the market, there are quite a number of good VPN services like NordVPN and Sharkvpn. They are inexpensive, low latency and reliable. Having said that you still have to pay.

By making use of the free tier compute resource provided by big cloud provider e.g. AWS, Microsoft Azure,Google and DigitalOcean, you can spin up virtual machine and setup your own VPN services!




### The following softwares are installed along with with the setup.ps1

*chocolatey - the package manager tool to install other tools
*terraform - to automate the VM provisioning on cloud platforms
*openssh - to generate a ssh key pair for authentication and download the OpenVPN config file to local
*OpenVPN client - to connect to the OpenVPN server for secure internet traffic


# Usage
DigitalOcean
$env:TF_VAR_DO_TOKEN = "xxx"

GCP
$env:TF_VAR_GCP_SAK_JSON="C:\credentials\My First Project-d7c90d1d29eb.json"
