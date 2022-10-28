:: This will check to see if Outlook/Office is installed, and then attempt to install if it is not present on the system.
ECHO OFF
IF EXIST "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE" (
    ECHO OfficeM365v2210 is already installed, skipping!
) ELSE (
    ECHO OfficeM365v2210 is NOT installed, installing!
    Start "\\SERVER\SHARE\OFFICE\setup.exe" /configure "\\SERVER\SHARE\OFFICE\Office365DeploymentConfiguration.xml"
)