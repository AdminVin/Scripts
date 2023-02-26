$ErrorActionPreference = "SilentlyContinue"

# Remove OLD Administrator account (if existing)
Remove-LocalUser -Name "CustomAdmin"
# Create NEW Administrator account
net user "CustomAdmin" "Password123!" /add
# Set password and account never to expire.
Set-LocalUser -Name "CustomAdmin" -PasswordNeverExpires 1 -AccountNeverExpires
# Add to Local Administrators on PC
Add-LocalGroupMember -Group "Administrators" -Member "CustomAdmin"