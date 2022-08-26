# List all users in that have not logged on within  
# XXX days in "Active Directory"  
#   
# This script requires the Active Directory Module from Microsoft.  
# It works with Server 2008 R2 and higher Domain Controllers 
# 
# Get the Current Date  
#   
$CurrentDate=GET-DATE  
#  
# Number of Days to check back.    
#   
$NumberDays=90  
#  
# Organizational Unit to search  
#  
$OU='OU=ParentCompany,DC=DOMAIN,DC=local'  
#  
Import-Module ActiveDirectory
GET-ADUSER -filter * -SearchBase $OU -properties LastLogonDate | where { $_.LastLogonDate.AddDays($NumberDays) -lt $CurrentDate } | Export-Csv "Users-Export-Inactivefor90Days.csv"
#  
# Add in a | DISABLE-ADAccount to AUTOMATICALLY Disable those accounts.  
# 
# Example  
# GET-ADUSER -filter * -SearchBase $OU -properties LastLogonDate | where { $_.LastLogonDate.AddDays($NumberDays) -lt $CurrentDate } | Disable-ADAccount 