# Run the setup.ps1

.\setenv.ps1
..\common\setup.ps1
# cd terraform
terraform destroy -auto-approve
terraform init
terraform apply -auto-approve
$dovpnip=terraform output ip
#$username=terraform output username


#ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i $HOME/.ssh/dovpn_id_rsa root@$dovpnip
scp -o StrictHostKeyChecking=no -i $HOME/.ssh/dovpn_id_rsa  root@${dovpnip}:/root/vpnuser1.ovpn ${env:USERPROFILE}\OpenVPN\config\

if (!(Test-Path ${env:USERPROFILE}\OpenVPN\config\vpnuser1.ovpn) ) {
    Write-Error "OpenVPN config file missing."
    exit 1
 }

$env:Path += ";C:\Program Files\OpenVPN\bin\" 
openvpn-gui.exe --connect vpnuser1


