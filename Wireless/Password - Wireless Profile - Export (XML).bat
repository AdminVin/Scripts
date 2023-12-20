echo off
:: Identify & reveal wireless password
netsh wlan show profile
echo *
set /p Wifiprofilename=Enter Wifi profile name you would like to see the password for (NOTE: Wifi profiles are case sensitive):
netsh wlan show profile "%Wifiprofilename%" key=clear

:: Export wireless profile to .XML
netsh wlan export profile name="%Wifiprofilename%" folder="C:\" key=clear

:: Notify
echo " "
echo "***********************************************************"
echo "Wireless Profile exported to C:\"
pause

:: If the above pulls the password encrypted, it will only work on your PC to add.
:: You can alternatively pull the password with NetSetMan Pro - https://www.netsetman.com/