if((Get-NetFirewallRule | Where-Object {$_.DisplayName -like "SMTP - Port - TCP (25)"}))
{
    Write-Host "Firewall Rule: SMTP - Port - TCP (25) already added!"
}
else {
    if((Get-WMIObject win32_operatingsystem) | Where-Object {$_.Name -like "Microsoft Windows 1*"}) 
    {
    $Name = "SMTP"
    $Protocol = "TCP"
    $Ports = "25"
    $FirewallProfile = "Any"
    New-NetFirewallRule -Direction Outbound -DisplayName "$Name - Port - $Protocol ($Ports)" -Protocol $Protocol -LocalPort $Ports -Profile $FirewallProfile -Action Block
    }
    else {
    Write-Host "OS is not Windows 10/11."
    }
}