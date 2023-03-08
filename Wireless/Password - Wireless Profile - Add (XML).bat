IF EXIST "C:\ProgramData\Company\Wireless\Wireless_InstallLog_v1.txt" (
  :: Wireless Profile installed
  echo Wireless profile already installed, skipping!
) ELSE (
  :: Install Wireless Profile
  mkdir C:\ProgramData\Company\Wireless\
  CD C:\ProgramData\Company\Wireless
  :: Remove "::" on next line & update "OLD_WIFI_PROFILE" to wireless profile name (case sensitive) being updated with new password.
  :: netsh wlan delete profile OLD_WIFI_PROFILE
  netsh wlan add profile filename="\\SERVER\PATH\To\XML\FILE.XML" user=all >Wireless_InstallLog_v1.txt
  echo Wireless profile installed!
)