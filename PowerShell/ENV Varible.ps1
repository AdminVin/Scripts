## Username
$env:username
# Example
Set-Location "C:\Users\$env:username\Desktop"

## Computer Name
$env:COMPUTERNAME
# Example
Set-ADComputer $env:computername -Description "My PC"

## Windows Dir
$env:windir
# Example
Set-Location "$env:windir\system32"