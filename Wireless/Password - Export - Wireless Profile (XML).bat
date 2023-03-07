:: Identify & reveal wireless password
netsh wlan show profile
echo *
set /p Wifiprofilename=Enter Wifi profile name you would like to see the password for (NOTE: Wifi profilesare case sensitive):
netsh wlan show profile "%Wifiprofilename%" key=clear
pause

:: Export wireless profile to .XML
netsh wlan export profile name="%Wifiprofilename%" folder="C:\" key=clear

:: Import profile to another computer
:: netsh wlan add profile filename="%Wifiprofilename%.XML" user=all

:: If your wireless password has special characters in it, they will have to be replaced with the legend below or will fail to add the profile properly.
:: " (change to) &quot;
:: & (change to) &amp;
:: ' (change to) &apos;
:: < (change to) &lt; 
:: > (change to) &gt;
:: 
:: Example: P@ssw0rd&123 should be P@ssw0rd&amp;123