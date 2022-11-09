# Show current version of PowerShell installed
$PSVersionTable

# Output
<#
Name                           Value
----                           -----
PSVersion                      7.2.6
PSEdition                      Core
GitCommitId                    7.2.6
OS                             Microsoft Windows 10.0.22621
Platform                       Win32NT
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0…}
PSRemotingProtocolVersion      2.3
SerializationVersion           1.1.0.1
WSManStackVersion              3.0
#>

# Install Latest Version
# No GUI
Invoke-Expression "& { $(Invoke-RestMethod https://aka.ms/install-powershell.ps1) }"
# GUI
Invoke-Expression "& { $(Invoke-RestMethod https://aka.ms/install-powershell.ps1) } -UseMSI"