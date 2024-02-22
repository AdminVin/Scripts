## Setup Notes
# Login to server > Scheduled Tasks > Create New Task (not basic)
# Schedule:  Tues/Weds @ 6 PM 
# Action > New
#       Program/Script: Point to PS7 (C:\Program Files\PowerShell\7\pwsh.exe)
#         Argument: -ExecutionPolicy Bypass -File "UNC or Local Path to this PS Script."

## PowerShell - Modules
# NuGet
if (-not (Get-PackageSource -Name 'NuGet' -ErrorAction SilentlyContinue)) {
    Install-PackageProvider -Name NuGet -Force
    Register-PackageSource -Name NuGet -ProviderName NuGet -Location https://www.nuget.org/api/v2 -Force
}
# PSWindowsUpdate
$minVersion = '2.2.1.4'
$moduleName = 'PSWindowsUpdate'
$module = Get-Module -Name $moduleName -ListAvailable | Where-Object { $_.Version -ge $minVersion } | Sort-Object Version -Descending | Select-Object -First 1
if (-not $module) {
    Install-Module -Name $moduleName -MinimumVersion $minVersion -Force -Scope CurrentUser
    Import-Module PSWindowsUpdate
} else {
    Import-Module PSWindowsUpdate
}


## Process Updates
# Check/Get
Get-WindowsUpdate
# Install
Install-WindowsUpdate -AcceptAll -Confirm:$false -IgnoreReboot