Function Check-Connectivity([array]$targets){

    #Start-Sleep -Seconds 5

    foreach ($target in $targets) {
        $connected = (Test-Connection -Computername $target -Quiet)

        if ($connected) {
            $result = "SUCCESS"
            Write-Host -ForegroundColor Green "Connection to ${target}(VPN Server): ${result}"
        } else {
            $result = "FAILURE"
            Write-Host -ForegroundColor Red "Connection to ${target}(VPN Server): ${result}"
        }        
    }
}

Function Verify-Path ([string]$mypath) {
    if (! (Test-Path $mypath -PathType leaf) ) {
        Write-Host "ERROR: ${mypath} not found or not a file!"
        Exit 1
    }
}


Function Stop-Generic ([string]$processname) {
    $processes = (Get-Process|Where-Object { $_.ProcessName -eq "${processname}" })
    foreach ($process in $processes) {
        Stop-Process $process.Id -Force
    }
}

Function Stop-Openvpn {
    Stop-Generic "openvpn"
}

Function Stop-Gui {
    Stop-Generic "openvpn-gui"
}
