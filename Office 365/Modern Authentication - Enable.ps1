# Enable Modern Authentication for Organization
Set-OrganizationConfig -OAuth2ClientProfileEnabled $true

# Verify Modern Authentication Status
Get-OrganizationConfig | Format-Table Name,OAuth* -Auto

# IT Environment Notes
# Outlook 2010 (No longer supported)
# Does not support modern authentication, and will need to use an app password.
# Must be updated to version 14.0.7182.5000, or it will reject the app password
#
# Outlook 2013
# Create User GPO to push out two registry keys to enable Modern Authentication
# HKCU\SOFTWARE\Microsoft\Office\15.0\Common\Identity - DWORD - EnableADAL - 1
# HKCU\SOFTWARE\Microsoft\Office\15.0\Common\Identity - DWORD - Version - 1
# If Modern Authentication should be forced when setting up accounts, add this registry key to the GPO above
# HKCU\Software\Microsoft\Exchange - DWORD - AlwaysUseMSOAuthForAutoDiscover - 1
#
# Outlook 2016 has modern authentication enabled by default.
# If Modern Authentication should be forced when setting up accounts, the below registry key should be pushed out via GPO
# HKCU\Software\Microsoft\Exchange - DWORD - AlwaysUseMSOAuthForAutoDiscover - 1