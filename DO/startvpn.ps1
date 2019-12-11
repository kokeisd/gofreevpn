# Run the setup.ps1
. ..\common\common.ps1
.\setenv.ps1
..\common\setup.ps1


Stop-Openvpn
Stop-Gui
terraform destroy -auto-approve

terraform init
If ($lastExitCode -ne "0") {
    Write-Error "Failed to run terrform init..."
    Exit $false
}

terraform apply -auto-approve
If ($lastExitCode -ne "0") {
    Write-Error "Failed to run terrform apply..."
    Exit $false
}

$gofreevpnip=terraform output ip
If ($lastExitCode -ne "0") {
    Write-Error "Failed to get the ip address of the VMs..."
    Exit $false
}
#$username="dovpnuser1"
#$username=terraform output username


#ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i $HOME/.ssh/gofreevpn_id_rsa root@$gofreevpnip
scp -o StrictHostKeyChecking=no -i $HOME/.ssh/gofreevpn_id_rsa  root@${gofreevpnip}:/root/${env:TF_VAR_DO_VPN_USER}.ovpn ${env:USERPROFILE}\OpenVPN\config\

if (!(Test-Path ${env:USERPROFILE}\OpenVPN\config\${env:TF_VAR_DO_VPN_USER}.ovpn) ) {
    Write-Error "OpenVPN config file missing."
    exit $false
 }

$env:Path += ";C:\Program Files\OpenVPN\bin\" 
openvpn-gui.exe --connect ${env:TF_VAR_DO_VPN_USER}

Start-Sleep -Seconds 10
#$vpnserver="10.8.0.1"
$vpnserver = @("10.8.0.1")
Check-Connectivity($vpnserver)
