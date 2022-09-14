netsh wlan show profile
echo *
set /p Wifiprofilename=Enter Wifi profile name you would like to see the password for (NOTE: Wifi profilesare case sensitive):
netsh wlan show profile "%Wifiprofilename%" key=clear
pause