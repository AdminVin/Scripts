# Query All Tools
Get-WindowsCapability -Online | ? Name -like "RSAT*"

# Install All Tools
Get-WindowsCapability -Online | ? Name -like "RSAT*"| Add-WindowsCapability -Online

# Install Active Directory
Add-WindowsCapability -Online -Name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0