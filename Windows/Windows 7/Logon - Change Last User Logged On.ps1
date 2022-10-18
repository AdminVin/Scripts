If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}

$UserID = Read-Host 'What is the Username?'
$UserID2 = Read-Host 'What is the Display Name?'

reg delete HKLM\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI /v LastLoggedOnUserSID /f
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI /v LastLoggedOnUser /d $UserID /f
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI /v LastLoggedOnSAMUser /d $UserID /f
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI /v LastLoggedOnDisplayName /d $UserID2 /f