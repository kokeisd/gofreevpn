[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 
#$env:TF_LOG="TRACE"
$env:TF_VAR_SSH_PUBKEY ="$HOME/.ssh/gofreevpn_id_rsa.pub"
$env:TF_VAR_SSH_PVTKEY = "$HOME/.ssh/gofreevpn_id_rsa"
# $env:TF_VAR_DO_TOKEN = "xxx"
