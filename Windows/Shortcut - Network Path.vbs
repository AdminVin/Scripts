Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objShell = CreateObject("WScript.Shell")

DesktopPath = objShell.SpecialFolders("Desktop")
Set NewShortcut = objShell.CreateShortcut(DesktopPath & "\misc.lnk")

If Not objFSO.FileExists (NewShortcut) Then
NewShortcut.Description = "New Shortcut"
NewShortcut.IconLocation = "%SystemRoot%\system32\SHELL32.dll,88"
NewShortcut.TargetPath = "\\192.168.168.196\Media"
NewShortcut.Save
End If

Set objFSO = nothing
Set objShell = nothing

WScript.Quit