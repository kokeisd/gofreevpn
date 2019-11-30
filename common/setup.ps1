
# install chocolatey
#@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

# Fix "The request was aborted: Could not create SSL/TLS secure channel" Error
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


function InstallApp {
	Param ([string]$appName)
	Write-Output "Installing $appName"
	#Get-AppxPackage $appName -AllUsers | Remove-AppxPackage
    #Get-AppXProvisionedPackage -Online | Where DisplayName -like $appName | Remove-AppxProvisionedPackage -Online
    choco install $appName -y --force 
}


$softwarelist = @(
    "OpenSSH"
    "Terraform"
    "OpenVPN"
);

$testchoco = powershell choco -v
if(-not($testchoco)){
    Write-Output "Chocolatey is not installed, installing now"
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
else{
    Write-Warning "Chocolatey Version $testchoco has already been installed"
}



foreach ($software in $softwarelist) {
    $isInstalled = choco list --local-only | Where-object { $_.ToLower().Contains($software.ToLower()) }
   
    if (-not($isInstalled)){
        if ($software -eq "OpenVPN") {
            choco install openvpn --params "'/SELECT_SHORTCUTS=1 /SELECT_OPENVPNGUI'" -y
        }
        else {
        InstallApp $software
        }
    }
    else{
        Write-Warning "$software has already been installed"
    }
}


Write-Host "====================="
Write-Host "Summary"
Write-Host "====================="
foreach ($software in $softwarelist) {
    $installedversion = choco list --local-only | Where-object { $_.ToLower().Contains($software.ToLower()) }
    Write-Host -ForegroundColor Green  $installedversion 
}
# install terraform
# $isTFInstalled = choco list --local-only | Where-object { $_.ToLower().Contains("terraform".ToLower()) }
# if (-not($isTFInstalled)){
#     choco install terraform --force -y
# }
# else{
#     Write-Output "Terraform verions $isTFInstalled has already been installed"
# }

# $isOVPNInstalled=choco list --local-only | Where-object { $_.ToLower().Contains("openvpn".ToLower())}
# if (-not($isOVPNInstalled)){
#     choco install openvpn --params "'/SELECT_SHORTCUTS=1 /SELECT_OPENVPNGUI'" -y
# }
# else {
#     Write-Output "OpenVPN verions $isOVPNInstalled has already been installed"
# }
# install openvpn client


# $isSSHInstalled=choco list --local-only | Where-object { $_.ToLower().Contains("openssh".ToLower())}
# if(-not($isSSHInstalled)){
#     choco install openssh -y
# }
# else {
#     Write-Output "OpenSSH verions $isSSHInstalled has already been installed"
# }
# install openssh





if (!(Test-Path "C:\Program Files\OpenSSH-Win64\ssh.exe" )){
    Write-Error "Openssh has not been installed. Exiting."
    exit 1
 } else {`
    Write-Host "Openssh has been installed successfully. Generating key pair..."
    $env:Path += ";C:\Program Files\OpenSSH-Win64\"
    if(!(Test-Path "$HOME/.ssh/dovpn_id_rsa" )){
        echo "Y"|ssh-keygen -t rsa   -f $HOME/.ssh/dovpn_id_rsa -N '""'
    }
    else{
        Write-Warning "SSH Key $HOME/.ssh/dovpn_id_rsa already exists. No new key will be generated."
        
    }
}






#$env:TF_LOG="TRACE"
# $env:TF_VAR_HOME = $HOME
# $env:TF_VAR_SSH_PUBKEY ="$HOME/.ssh/dovpn_id_rsa.pub"
# $env:TF_VAR_SSH_PVTKEY = "$HOME/.ssh/dovpn_id_rsa"
# $env:TF_VAR_DO_TOKEN = "6147998f3dbf1f8163864685359dcceb094658e03ed038336cf98d50a70c7c28"

# Set-Location terraform
# terraform init
# terraform apply -auto-approve
# $dovpnip=terraform output ip
# $username=terraform output username
# 
# #ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i $HOME/.ssh/dovpn_id_rsa root@$dovpnip
# scp -o StrictHostKeyChecking=no -i $HOME/.ssh/dovpn_id_rsa  root@${dovpnip}:/root/${username}.ovpn ${env:USERPROFILE}\OpenVPN\config\
# 
# $env:Path += ";C:\Program Files\OpenVPN\bin\" 
# openvpn-gui.exe --connect ${username}