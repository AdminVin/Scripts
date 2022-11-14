# Windows Updates
# Source: https://www.powershellgallery.com/packages/PSWindowsUpdate

# Install Module
Install-Module -Name PSWindowsUpdate

# View Windows Update History
Get-WUHistory

# Get All Windows Updates
Get-WindowsUpdate

# Install ALL Windows Updates
Install-WindowsUpdate

# Scope Windows Update to KB
Get-WindowsUpdate -Install -KBArticleID 'KB4560960'
