# This script needs to be ran in PowerShell ISE (as Admin) to function correctly.

#Get Graph API Intune Module
Install-Module NuGet
Install-Module -Name Microsoft.Graph.Intune
Import-Module Microsoft.Graph.Intune -Global
 
#The path where the scripts will be saved
$Date = Get-Date -UFormat %m-%d-%Y
New-Item -Path "C:\InTune - PowerShell Scripts ($Date)" -ItemType Directory
$Path = "C:\InTune - PowerShell Scripts ($Date)"
Write-Host ""
Write-Host "PowerShell Scripts will be downloaded to $Path" -ForegroundColor Yellow
Write-Host ""
 
#The connection to Azure Graph
Connect-MSGraph 
 
#Get Graph scripts
$ScriptsData = Invoke-MSGraphRequest -Url "https://graph.microsoft.com/beta/deviceManagement/deviceManagementScripts" -HttpMethod GET
 
$ScriptsInfos = $ScriptsData.value | Select-Object id,fileName,displayname
$NBScripts = ($ScriptsInfos).count
 
if ($NBScripts -gt 0){
    Write-Host "Found $NBScripts scripts :" -ForegroundColor Yellow
    $ScriptsInfos | FT DisplayName,filename
    Write-Host "Downloading Scripts..." -ForegroundColor Yellow
    foreach($ScriptInfo in $ScriptsInfos){
        #Get the script
        $script = Invoke-MSGraphRequest -Url "https://graph.microsoft.com/beta/deviceManagement/deviceManagementScripts/$($scriptInfo.id)" -HttpMethod GET
        #Save the script
        [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($($script.scriptContent))) | Out-File -FilePath $(Join-Path $Path $($script.fileName))  -Encoding ASCII 
    }
    Write-Host "All scripts downloaded to $Path!" -ForegroundColor Yellow        
}