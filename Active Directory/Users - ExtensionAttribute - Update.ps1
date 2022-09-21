$Username = "AdminVin"

# Clear existing data in exenstionAttribute1
Set-ADUser -Identity $Username -Clear extensionAttribute1
# Set new data for extensionAttribute1
Set-ADUser -Identity $Username -Add @{extensionAttribute1="Disabled"}