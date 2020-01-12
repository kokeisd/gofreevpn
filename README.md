# gofreevpn

This package makes use of free tiers of public cloud providers to build a free personal VPN service.

# Why

There are a number of good reasons why people would like to use VPN to secure their online traffic or prevent their real IP address from being identified by the other side of commnuication. For example, some online shopping or video streamming services only provide services to certain regions(based on your IP address). Or in some situations where you need to visit a website indirectly because of firewall or DNS restrictions.

In the market, there are quite a number of good VPN services like NordVPN and Sharkvpn. They are inexpensive, low latency and reliable. Having said that you still have to pay. By taking advantage of the free tier compute resource provided by big cloud providers e.g. AWS, Microsoft Azure,Google and DigitalOcean, you can spin up virtual machine and setup your own free VPN services!


# How this package works

This package will first install the following softwares on your Windows 10 desktop and then build a cloud VM and setup and setup a VPN server.

### The following softwares are installed along with with the setup.ps1

* chocolatey - the package manager tool to install other tools
* terraform - to automate the VM provisioning on cloud platforms
* openssh - to generate a ssh key pair for authentication and download the OpenVPN config file to local
* OpenVPN client - to connect to the OpenVPN server for secure internet traffic


# Usage
After you decided the public cloud provider that you want to build your VPN server(Currently this project supports Google Cloud Platform and DigitalOcean), you need to register a free access with the cloud provider.

Once you have access to the free tier cloud services, the next step is to generate the API  token so that your VPN server can be built programmatically. The API token generation steps varies depending on the cloud provider you chose. 

## DigitalOcean
To use DigitalOcean, you need first create a free account and generate a API token([link](https://www.digitalocean.com/docs/api/create-personal-access-token/))

``` Powershell
# Run with admin permission
$env:TF_VAR_DO_TOKEN = "<access_token>"
$env:TF_VAR_DO_REGION = "<region>"   # list of regions can be found [here](https://www.digitalocean.com/docs/platform/availability-matrix/)
```

## GCP
For GCP, you can follow this [link](https://cloud.google.com/community/tutorials/getting-started-on-gcp-with-terraform) to create a project and generate a credential file.

``` Powershell
$env:TF_VAR_GCP_SAK_JSON="<path_to_cred_file>"
$env:TF_VAR_GCP_ZONE="<zone>"  # list of zone can be found [here](https://cloud.google.com/about/locations/)
$env:TF_VAR_GCP_PROJ_ID="<project_id>"
```
