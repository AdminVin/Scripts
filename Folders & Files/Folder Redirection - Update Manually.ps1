$OldProfPath = $env:USERPROFILE
$NewUserName = $env:USERNAME
$OldUPN = ($env:USERPROFILE -split "\\")[2]
$newFileServer = "serverNEW"
$oldFileServer = "serverOLD"

$DesktopPath = $OldProfPath+"\Desktop"
$DesktopUserPath = "%USERPROFILE%\Desktop"

$FAVPath = $OldProfPath+"\Favorites"
$FAVUserPath = "%USERPROFILE%\Favorites"


$MusicPath = $OldProfPath+"\My Music"
$MusicUserPath = "%USERPROFILE%\My Music"

$VideoPath = $OldProfPath+"\Videos"
$VideoUserPath = "%USERPROFILE%\My Videos"

$picPath = $OldProfPath+"\My Pictures"
$PicUserPath = "%USERPROFILE%\My Pictures"
#update to reflect enviroment
$DocPath = "\\"+$newFileServer+"\UserData\"+$NewUserName+"\Documents"

#update to reflect enviroment
$oldServerDoc= "\\"+$oldFileServer+"\UserData\"+$OldUPN+"\Documents"

#move Music, PICs, And vidoes. To be Local
#if(Test-Path $oldServerDoc\My Music){
#Echo "Copying Music Folder"
#Copy-Item $oldServerDoc\My Music $OldProfPath\My Music  -Recurse -Force -Verbose
#}

#if(Test-Path $oldServerDoc\My Videos){
#Copy-Item $oldServerDoc\My Videos $OldProfPath\My Videos  -Recurse -Force -Verbose
#Echo "Copying Video Folder"
#}

#if(Test-Path $oldServerDoc\My Pictures){
#Copy-Item $oldServerDoc\My Pictures $OldProfPath\My Pictures  -Recurse -Force -Verbose
#Echo "Copying Picture Folder"
#}
#Move Doc To New Server Location
#Echo "Copying Doc Folder"
#Copy-Item $oldServerDoc $DocPath  -Recurse -Force -Verbose



#update reg to have the properpath info so that the library works
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders' -Name "Desktop" -Value $DesktopPath
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -Name "Desktop" -Value $DesktopUserPath
 
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders' -Name "My Music" -Value $MusicPath
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -Name "My Music" -Value $MusicUserPath

Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders' -Name "Personal" -Value $DocPath
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -Name "Personal" -Value $DocPath

Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders' -Name "My Video" -Value $VideoPath
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -Name "My Video" -Value $VideoUserPath

Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders' -Name "My Pictures" -Value $PicPath
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -Name "My Pictures" -Value $PicUserPath

Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders' -Name "Favorites" -Value $FAVPath
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -Name "Favorites" -Value $FAVUserPath

#Cleanup IE so users can save passwords 
Remove-ItemProperty -Path "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\IntelliForms" -Name "Storage2"

#run GPupdat and except result f either logoff or reboot

echo Y | gpupdate /force
