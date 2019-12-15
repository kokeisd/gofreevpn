[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 
$env:Path += ";C:\Program Files\OpenVPN\bin\"
$env:TF_VAR_SSH_PUBKEY ="$HOME/.ssh/gofreevpn_id_rsa.pub"
$env:TF_VAR_SSH_PVTKEY = "$HOME/.ssh/gofreevpn_id_rsa"
$env:TF_VAR_DO_VPN_USER = "dovpnuser1"
# $env:TF_LOG="TRACE"
