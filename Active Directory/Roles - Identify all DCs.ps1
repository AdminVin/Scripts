## Option 1 - PowerShell
# Identify all Domain Controllers
Get-ADDomainController -Filter * | Select-Object Hostname
# Identify FSMO Roles
Get-ADDomain | Select-Object InfrastructureMaster, PDCEmulator, RIDMaster
Get-ADForest | Select-Object SchemaMaster, DomainNamingMaster


## Option 2 - Command Prompt (as administrator)
# Identify all Domain Controllers
NETDOM QUERY DC
# Identify FSMO Roles
NETDOM QUERY FSMO