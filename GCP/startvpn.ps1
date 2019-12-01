

.\setenv.ps1

# cd terraform
terraform destroy -auto-approve
terraform init
terraform apply -auto-approve
$gofreevpnip=terraform output ip
$username="vpnuser1"

#ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i $HOME/.ssh/gofreevpn_id_rsa root@$gofreevpnip
scp -o StrictHostKeyChecking=no -i ${env:TF_VAR_SSH_PVTKEY} ${env:TF_VAR_GCP_SSH_USER}@${gofreevpnip}:~/${username}.ovpn ${env:USERPROFILE}\OpenVPN\config\

if (!(Test-Path ${env:USERPROFILE}\OpenVPN\config\${username}.ovpn) ) {
    Write-Error "OpenVPN config file missing."
    exit 1
 }

$env:Path += ";C:\Program Files\OpenVPN\bin\" 
openvpn-gui.exe --connect ${username}


