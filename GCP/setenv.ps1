# create service account
# https://docs.bmc.com/docs/PATROL4GoogleCloudPlatform/10/creating-a-service-account-key-in-the-google-cloud-platform-project-799095477.html
# $env:TF_VAR_GOOGLE_CLOUD_KEYFILE_JSON="E:\credentials\My First Project-d7c90d1d29eb.json"


# change TF_VAR_GCP_SSH_USER to SSH_USER

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 
#$env:TF_VAR_GCP_SAK_JSON="c:\keys\testproject-d51d406f63eb.json"
$env:TF_VAR_GCP_SAK_JSON="C:\credentials\My First Project-d7c90d1d29eb.json"
$env:TF_VAR_GCP_PROJ_ID="neural-store-233409"
$env:TF_VAR_SSH_PUBKEY ="$HOME/.ssh/gofreevpn_id_rsa.pub"
$env:TF_VAR_SSH_PVTKEY = "$HOME/.ssh/gofreevpn_id_rsa"
$env:TF_VAR_GCP_SSH_USER = "user1"
$env:TF_VAR_GCP_VPN_USER = "gcpvnpuser1"