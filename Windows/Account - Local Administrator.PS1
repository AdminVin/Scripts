<# Add Local Admin #>
Remove-LocalUser -Name "CustomAdmin"                                                                            # Remove OLD Administrator account (if existing)
$securePass = ConvertTo-SecureString "Password123!" -AsPlainText -Force                                         # Create NEW Administrator account
New-LocalUser -Name "CustomAdmin" -Password $securePass -FullName "Custom Admin" -Description "Local Admin"
Set-LocalUser -Name "CustomAdmin" -PasswordNeverExpires 1 -AccountNeverExpires                                  # Set password and account never to expire.
Add-LocalGroupMember -Group "Administrators" -Member "CustomAdmin"                                              # Add to Local Administrators on PC

<# Disable Account #>
Disable-LocalUser -Name "CustomAdmin"

<# Delete Account #>
Remove-LocalUser -Name "CustomAdmin"