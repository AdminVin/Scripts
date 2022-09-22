IF EXIST "C:\ProgramData\Company\Wireless\WirelessInstall-Log.txt" (
  :: Wireless Profile installed
  echo Wireless profile already installed, skipping!
) ELSE (
  :: Install Wireless Profile
  mkdir C:\ProgramData\Company\Wireless\
  CD C:\ProgramData\Company\Wireless
  netsh wlan add profile filename="\\SERVER\PATH\To\XML\FILE.XML" user=all >WirelessInstall-Log.txt
  echo Wireless profile installed!
)

:: XML File Protection
::
:: For the GPO you will need to add "Domain Computers" to READ and APPLY the GPO SETTINGS to the scope
:: This should be a computer startup script to add the wireless SSID to the workstations.
::
:: For the XML file permissions, grant READ for "Domain Computers" and then set a DENY for "Domain Users"
:: With this setup, "Domain Computers" will be able to read the file when it is starting up, and when the user is logged in, DENY permissions will take effect not allowing them to open the file and reveal the password.
::
:: SSID Password Updates
:: Updating the password for the SSID will require exporting a fresh XML file, and then re-setting permissions.