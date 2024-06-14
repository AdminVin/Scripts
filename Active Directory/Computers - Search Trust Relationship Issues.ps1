# Import AD Module           
Import-Module ActiveDirectory

# OU
$OU = "OU=Computers,DC=DOMAIN,DC=local"

# Pull Computer List from the specified OU
Get-ADComputer -Filter * -SearchBase $OU -Properties LastLogonDate | Where-Object { $_.LastLogonDate -GT (Get-Date).AddDays(-90) } | Select-Object DNSHostName | Export-CSV PCsActive90D.csv
$Computers = Import-Csv -Path PCsActive90D.csv

# Initialize results array
$Results = @()

# Test if PC has Trust Relationship Issue
foreach ($computer in $Computers) {
    $PCName = $computer.DNSHostName
    Write-Output "Testing $PCName"
    
    # Check if computer is reachable
    if (Test-Connection -ComputerName $PCName -Count 1 -Quiet) {
        try {
            $result = Invoke-Command -ComputerName $PCName -ScriptBlock { Test-ComputerSecureChannel }
            if ($result -eq $false) {
                Write-Host "$PCName has a trust relationship issue." -ForegroundColor Red
                $Results += [PSCustomObject]@{PCName=$PCName; Result="False"}
            }
        } catch {
            Write-Host "$PCName could not run the test." -ForegroundColor Yellow
            $Results += [PSCustomObject]@{PCName=$PCName; Result="Could not run test"}
        }
    } else {
        Write-Host "$PCName is offline." -ForegroundColor Yellow
        $Results += [PSCustomObject]@{PCName=$PCName; Result="Offline"}
    }
}

# Export results to CSV
$Results | Export-Csv -Path "C:/AD-TrustRelationshipIssues.csv" -NoTypeInformation
