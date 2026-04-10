echo off
:: Identify & reveal wireless password
netsh wlan show profile
echo *
set /p Wifiprofilename=Enter Wifi profile name you would like to see the password for (NOTE: Wifi profiles are case sensitive):
netsh wlan show profile "%Wifiprofilename%" key=clear
echo "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
echo "<><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
echo "Note:"
echo "You must use NetManSet to export the XML profle."
echo "<><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
echo "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
pause