:: This will check to see if Outlook/Office is installed, and then attempt to install if it is not present on the system.
IF EXIST "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE" (
	ECHO OFFICE INSTALLED, SKIPPING!
) ELSE (
	robocopy "\\SERVER\SHARE\Office 2021" "C:\Windows\Temp\Office" /MIR
	CD "C:\Windows\Temp\Office"
	start setup.exe /configure Office365DeploymentConfiguration.xml
)