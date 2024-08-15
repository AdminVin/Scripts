# Source: https://activedirectorypro.com/enable-active-directory-recycle-bin-server-2016/

# Enable
Import-Module ActiveDirectory
$Domain = "ADMINVIN.LOCAL"
Enable-ADOptionalFeature 'Recycle Bin Feature' -Scope ForestOrConfigurationSet -Target $Domain

# Verify AD Recycle Bin is Enabled
Get-ADOptionalFeature -filter *

## "EnabledScopes" will be populated with OU paths if enabled properly.