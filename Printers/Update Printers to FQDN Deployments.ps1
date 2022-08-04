$GPOName = Read-Host -Prompt 'Enter in the GPO Name e.g. [C] Printer Deployment (Sitename)'
Function Modify-PushedPrinterConnections
{
[cmdletbinding(SupportsShouldProcess=$True)]
 
Param
    (
        #The name of the Old Print Server. This string will be searched for in order to be replaced.
        [Parameter(Mandatory=$true)]
        [string]$GPName
    )
 
#Collection detailing all of the work
$GPOPrinterDetails = @()
$DomainName = (Get-WmiObject Win32_ComputerSystem).Domain
$domain = ((Get-WmiObject Win32_ComputerSystem).Domain).split('.')[0]
$GPOs = Get-GPO -Name $GPName
 
ForEach ($GPO in $GPOs)
{
    $PrintObjects = Get-ADObject -SearchBase "CN={$($GPO.Id)},CN=Policies,CN=System,DC=$Domain,DC=local" -Filter {objectClass -eq "msPrint-ConnectionPolicy"} -SearchScope Subtree
    
    ForEach ($PCO in $PrintObjects)
    {
        #Get the properties of the Print Connection Object that we actually need.
        $PrintConnection = Get-ADObject $PCO.DistinguishedName -Properties printerName, serverName, uNCName
        
        #Log details of the policy that we have found    [0]
        $GPOPrinterDetail = @{
                    GPOId = $GPO.Id
                    GPOName = $GPO.DisplayName
                    PrintConnectionID = $PrintConnection.ObjectGUID
                    PrinterName = $PrintConnection.printerName
                    OriginalPrintServer = $PrintConnection.serverName
                    OriginalUNCName = $PrintConnection.uNCName
                    NewPrintServer = $null
                    NewUNCName = $null
                    ChangeStatus = "NotEvaluated"
                    }
        
        #Find out if we need to make a change or not.
        If ($PrintConnection.serverName.ToLower() -contains $DomainName.ToLower())
        {
            $GPOPrinterDetail.ChangeStatus = "NoChange"
                
        }
        Else
        {
            
                 #Change the local instance
            $CurrentServerName = $PrintConnection.serverName
            $PrintConnection.serverName = "$($CurrentServerName).$DomainName"
            $PrintConnection.uNCName = $PrintConnection.uNCName.Replace($CurrentServerName,"$($CurrentServerName).$DomainName")
            
            #Update our reporting collection
            $GPOPrinterDetail.NewPrintServer = $PrintConnection.serverName
            $GPOPrinterDetail.NewUNCName = $PrintConnection.uNCName
            $GPOPrinterDetail.ChangeStatus = "ChangePending"
                        
            #Write the changes and catch any errors
            Try
                {Set-ADObject -Instance $PrintConnection -Verbose
                $GPOPrinterDetail.ChangeStatus = "ChangeSuccess"}
            Catch
                {$GPOPrinterDetail.ChangeStatus = "ChangeFailed"}
        }
 
        #Update the table
        $GPOPrinterDetails += New-Object PSObject -Property $GPOPrinterDetail
    }
 
}
 
#Finally write out the changes
Write-Output $GPOPrinterDetails
Write-Output $GPOPrinterDetails | Export-CSV "Update Printers to FQDN Deployments - LOG.csv"
 
}

Modify-PushedPrinterConnections -GPName $GPOName
Pause