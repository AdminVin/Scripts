IF EXIST "C:\ProgramData\Company\Wireless\SSID_2026-04-08.txt" (
  :: Wireless Profile installed
  echo Wireless profile already installed, skipping!
) ELSE (
  :: Install Wireless Profile
  mkdir C:\ProgramData\Company\Wireless\
  CD /D C:\ProgramData\Company\Wireless

  del /f /q "C:\Windows\Temp\SSID.xml" 2>nul
  copy "\\SERVER\gpo\Wireless\SSID.xml" "C:\Windows\Temp\SSID.xml" /Y

  netsh wlan delete profile SSID
  netsh wlan add profile filename="C:\Windows\Temp\SSID.xml" user=all >SSID_2026-04-08.txt
)