# This will create a shortcut in Start Menu icons for Devices & Printers
$ShortcutPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath("CommonPrograms"), "Devices & Printers.lnk")
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = "shell:::{A8A91A66-3A7D-4424-8D24-04E180695C7A}"
$Shortcut.Save()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($WshShell) | Out-Null