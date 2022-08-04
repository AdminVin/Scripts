# Windows Updates

# Install Module
Install-Module PSWindowsUpdate

# Get All Windows Updates
Get-WindowsUpdate

# Install ALL Windows Updates
Install-WindowsUpdate

# Scope Windows Update to KB
Get-WindowsUpdate -Install -KBArticleID 'KB4560960'
