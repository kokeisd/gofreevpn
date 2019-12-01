$ gofreevpn

This package makes use of free tiers of public cloud providers to build a private VPN and establish a secure VPN connection on Windows 10.

#Why

There are a number of good reasons why people would like to use VPN to secure their online traffic or prevent their real IP address from being identified by the other side of commnuication. For example, some online shopping or video streamming services only provide services to certain regions(based on your IP address). Or in some situations where you can visit a website directly because of firewall or DNS restrictions.

In the market, there are quite a number of good VPN services like NordVPN and Sharkvpn. They are inexpensive, low latency and reliable. Having said that you still have to pay. By making use of the free tier compute resource provided by big cloud providers e.g. AWS, Microsoft Azure,Google and DigitalOcean, you can spin up virtual machine and setup your own free VPN services!


#How this package works
This package will first install the following softwares on your Windows 10 desktop and then build a cloud VM and setup and setup a VPN server.

###The following softwares are installed along with with the setup.ps1

*chocolatey - the package manager tool to install other tools
*terraform - to automate the VM provisioning on cloud platforms
*openssh - to generate a ssh key pair for authentication and download the OpenVPN config file to local
*OpenVPN client - to connect to the OpenVPN server for secure internet traffic


#Usage
First off, you need to select the cloud provider where you want to build your VPN server. The current support Google Cloud Platform and DigitalOcean

##DigitalOcean
To use DigitalOcean, you need first create a free account and generate a API token([link](https://www.digitalocean.com/docs/api/create-personal-access-token/))

$env:TF_VAR_DO_TOKEN = "xxx"

##GCP
$env:TF_VAR_GCP_SAK_JSON="C:\credentials\My First Project-d7c90d1d29eb.json"
$env:TF_VAR_GCP_ZONE="asia-east2"
$env:TF_VAR_GCP_ZONE="us-west1-a"
