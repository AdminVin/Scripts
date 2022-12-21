::::::::::::
:: Syntax ::
::::::::::::

IF EXIST "filename" (
  ECHO "File detected.  No additional changes needed!"
) ELSE (
  ECHO " File NOT detected.  Installing!"
)

:::::::::::::
:: Example ::
:::::::::::::

IF EXIST "C:\Test\WirelessInstall-Log.txt" (
  :: Wireless Profile Installed.
  echo Wireless profile already installed, skipping!
) ELSE (
  :: Wireless Profile NOT Installed.
  mkdir C:\Test\
  CD C:\Test\
  netsh wlan add profile filename="\\SERVER\SHARE\WirelessProfile.xml" user=all >WirelessInstall-Log.txt
  echo Wireless profile installed!
)