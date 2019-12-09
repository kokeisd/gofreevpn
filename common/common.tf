$govpnip=terraform output ip
$username=terraform output username

scp -o StrictHostKeyChecking=no -i $HOME/.ssh/gofreevpn_id_rsa  root@${govpnip}:/root/${username}.ovpn ${env:USERPROFILE}\OpenVPN\config\

$env:Path += ";C:\Program Files\OpenVPN\bin\" 
openvpn-gui.exe --connect ${username}

if (!(Test-Path ${env:USERPROFILE}\OpenVPN\config\${username}.ovpn) ) {
    Write-Error "OpenVPN config file missing."
    exit 1
 }


 