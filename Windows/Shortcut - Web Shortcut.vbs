Set objShell = WScript.CreateObject("WScript.Shell")
 
'All users Desktop
allUsersDesktop = objShell.SpecialFolders("AllUsersDesktop")
 
'The current users Desktop
usersDesktop = objShell.SpecialFolders("Desktop")
 
'Where to create the new shorcut
Set objShortCut = objShell.CreateShortcut(usersDesktop & "\Office365 - Web Mail.url")
 
'What does the shortcut point to
objShortCut.TargetPath = "http://mail.office365.com"
 
'Create the shortcut
objShortCut.Save