# Delete old account (if needed)
net user "YourAdminAccount" /delete
# Create new account
net user "YourAdminAccount" "YourAccountPassword" /add /active:yes
# Add Account to Administrators Group
net localgroup /add Administrators "YourAdminAccount"
# Set Password to Never Expire
powershell Set-LocalUser -Name "YourAdminAccount" -PasswordNeverExpires 1