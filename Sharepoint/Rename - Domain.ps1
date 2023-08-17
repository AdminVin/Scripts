# Source: https://learn.microsoft.com/en-us/sharepoint/change-your-sharepoint-domain-name

<# Install SharePoint Online Management Shell
https://www.microsoft.com/en-us/download/details.aspx?id=35588

Example Scenario

(Existing Setup)
Old Domain: OldCompany.com
Old "On Microsoft" Domain: OldCompany.OnMicrosoft.com
Old SharePoint Main Site URL: OldCompany.SharePoint.com

(End Result)
New Domain: NewCompany.com
New "On Microsoft" Domain: NewCompany.OnMicrosoft.com
New SharePoint Main Site URL: NewCompany.SharePoint.com
#>

# Navigate to https://aka.ms/SPORenameAddDomain and add new "On Microsoft" domain in Azure.

# Connect to SharePoint Online (The '-admin' after your domain is required)
Connect-SPOService -URL "https://OldCompany-admin.sharepoint.com"

# Schedule the rename (must be 24 hours in advance)
# Syntax Format:
# Start-SPOTenantRename -DomainName <DomainName> -ScheduledDateTime <YYYY-MM-DDTHH:MM:SS>
Start-SPOTenantRename -DomainName "NewCopany" -ScheduledDateTime 2023-08-17T10:35:00

# Stop a rename change (that has not started yet)
Stop-SPOTenantRename

# Check Rename Status
Get-SPOTenantRenameStatus