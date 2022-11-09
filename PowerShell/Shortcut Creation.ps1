# Paths
$FilePath = "C:\Users\$env:username\AppData\Local\Microsoft\OneDrive\OneDrive.exe"
$ShortcutPath = "C:\Users\$env:username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\OneDrive.lnk"
# Create Shortcut
$WScriptObj = New-Object -ComObject ("WScript.Shell")
$Shortcut = $WscriptObj.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = $FilePath
$Shortcut.Save()