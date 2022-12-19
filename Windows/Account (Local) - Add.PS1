net user "YourAdminAccount" /delete
net user "YourAdminAccount" "YourAccountPassword" /add /active:yes
net localgroup /add Administrators "YourAdminAccount"
powershell Set-LocalUser -Name "YourAdminAccount" -PasswordNeverExpires 1