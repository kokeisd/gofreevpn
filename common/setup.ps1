
# install chocolatey
#@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

# Fix "The request was aborted: Could not create SSL/TLS secure channel" Error
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


function InstallApp {
	Param ([string]$appName)
	Write-Output "Installing $appName"
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
Write-Host "Summary of software setup"
Write-Host "====================="
foreach ($software in $softwarelist) {
    $installedversion = choco list --local-only | Where-object { $_.ToLower().Contains($software.ToLower()) }
    Write-Host -ForegroundColor Green  $installedversion 
}


if (!(Test-Path "C:\Program Files\OpenSSH-Win64\ssh.exe" )){
    Write-Error "Openssh has not been installed. Exiting."
    exit 1
 } else {`
    Write-Host "Openssh has been installed successfully. Generating key pair..."
    $env:Path += ";C:\Program Files\OpenSSH-Win64\"
    if(!(Test-Path "$HOME/.ssh/gofreevpn_id_rsa" )){
        echo "Y"|ssh-keygen -t rsa   -f $HOME/.ssh/gofreevpn_id_rsa -N '""'
    }
    else{
        Write-Warning "SSH Key $HOME/.ssh/gofreevpn_id_rsa already exists. No new key will be generated."
        
    }
}
