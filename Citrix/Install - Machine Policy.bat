ECHO OFF
IF EXIST "C:\Program Files (x86)\Citrix\Citrix WorkSpace 2210\PackageInstaller.exe" (
    ECHO Citrix Workspace 2210 is already installed, skipping!
) ELSE (
    ECHO Citrix Workspace 2210 is NOT installed, installing!
    "\\SERVER\SHARE\[C] Citrix - Settings\Install\2210\CitrixWorkspaceApp.exe" /silent
)