#region Modules
Import-Module ActiveDirectory
#endregion

#region Varibles
# Default computer OU
$defaultlocation = "CN=Computers,DC=DOMAIN,DC=Local"

# New Locations
$location1 = "OU=Computers,OU=Company,DC=DOMAIN,DC=local"
$location2 = "OU=Computers,OU=Company,DC=DOMAIN,DC=local"
$location3 = "OU=Computers,OU=Company,DC=DOMAIN,DC=local"
$location4 = "OU=Computers,OU=Company,DC=DOMAIN,DC=local"
$location5 = "OU=Computers,OU=Company,DC=DOMAIN,DC=local"
$location6 = "OU=Computers,OU=Company,DC=DOMAIN,DC=local"
$location7 = "OU=Computers,OU=Company,DC=DOMAIN,DC=local"
$location8 = "OU=Computers,OU=Company,DC=DOMAIN,DC=local"
$location9 = "OU=Computers,OU=Company,DC=DOMAIN,DC=local"
$location10 = "OU=Computers,OU=Company,DC=DOMAIN,DC=local"
$location11 = "OU=Computers,OU=Company,DC=DOMAIN,DC=local"
$location12 = "OU=Computers,OU=Company,DC=DOMAIN,DC=local"
$location13 = "OU=Computers,OU=Company,DC=DOMAIN,DC=local"
#endregion

#region Process Computer Objects
Get-ADComputer -Filter {name -like "PCNamePrefix*"} -SearchBase $defaultlocation | Move-ADObject -Targetpath $location1
Get-ADComputer -Filter {name -like "PCNamePrefix*"} -SearchBase $defaultlocation | Move-ADObject -Targetpath $location2
Get-ADComputer -Filter {name -like "PCNamePrefix*"} -SearchBase $defaultlocation | Move-ADObject -Targetpath $location3
Get-ADComputer -Filter {name -like "PCNamePrefix*"} -SearchBase $defaultlocation | Move-ADObject -Targetpath $location4
Get-ADComputer -Filter {name -like "PCNamePrefix*"} -SearchBase $defaultlocation | Move-ADObject -Targetpath $location5
Get-ADComputer -Filter {name -like "PCNamePrefix*"} -SearchBase $defaultlocation | Move-ADObject -Targetpath $location6
Get-ADComputer -Filter {name -like "PCNamePrefix*"} -SearchBase $defaultlocation | Move-ADObject -Targetpath $location7
Get-ADComputer -Filter {name -like "PCNamePrefix*"} -SearchBase $defaultlocation | Move-ADObject -Targetpath $location8
Get-ADComputer -Filter {name -like "PCNamePrefix*"} -SearchBase $defaultlocation | Move-ADObject -Targetpath $location9
Get-ADComputer -Filter {name -like "PCNamePrefix*"} -SearchBase $defaultlocation | Move-ADObject -Targetpath $location10
Get-ADComputer -Filter {name -like "PCNamePrefix*"} -SearchBase $defaultlocation | Move-ADObject -Targetpath $location11
Get-ADComputer -Filter {name -like "PCNamePrefix*"} -SearchBase $defaultlocation | Move-ADObject -Targetpath $location12
Get-ADComputer -Filter {name -like "PCNamePrefix*"} -SearchBase $defaultlocation | Move-ADObject -Targetpath $location13
#endregion