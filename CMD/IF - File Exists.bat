::::::::::::
:: Syntax ::
::::::::::::

IF EXIST "filename" (
  REM Do one thing
) ELSE (
  REM Do another thing
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