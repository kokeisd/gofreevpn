$govpnip=terraform output ip
$username=terraform output username

#ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i $HOME/.ssh/dovpn_id_rsa root@$govpnip
scp -o StrictHostKeyChecking=no -i $HOME/.ssh/dovpn_id_rsa  root@${govpnip}:/root/${username}.ovpn ${env:USERPROFILE}\OpenVPN\config\

$env:Path += ";C:\Program Files\OpenVPN\bin\" 
openvpn-gui.exe --connect ${username}


if (!(Test-Path ${env:USERPROFILE}\OpenVPN\config\${username}.ovpn) ) {
    Write-Error "OpenVPN config file missing."
    exit 1
 }